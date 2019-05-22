//
//  ViewController.swift
//  20190514-EduardoSantiz-NYCSchools
//
//  Created by Eduardo Santiz on 5/14/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties.
    
    let vm = ViewModel() //Renombrar "vm" a "viewModel"
    let highSchoolsDirectory = [HighSchools].self
    let schoolsDetails = [AditionalInformation].self
    
    // MARK: - Outlets.
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Network Calls.
        
        vm.downloadData(modelName: highSchoolsDirectory) {
            DispatchQueue.main.async {
                self.vm.setArray(from: self.highSchoolsDirectory)
                self.tableView.reloadData()
            }
        }
        
        vm.downloadData(modelName: [AditionalInformation].self) { self.vm.setArray(from: [AditionalInformation].self) }
        
        // MARK: - Delegates.
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - TableView Cell Configuration.
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 100.0
    }

}

// MARK: - Table View Delegate Methods.

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getNumberOfItemsInArray(fromModel: highSchoolsDirectory)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = vm.getSchoolName(fromModel: highSchoolsDirectory, index: indexPath.row)
        cell.detailTextLabel?.text = vm.getSchoolLocation(index: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .blue
        cell.tintColor = UIColor.red
        cell.isUserInteractionEnabled = true
        
        if !vm.schoolHasDetails(index: indexPath.row) {
            cell.accessoryType = .none
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textColor = .darkText
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController //Evita hacer force unwrapping, mejor usa optional binding con "?"
        vc.schoolDetail = vm.getSchoolDetails(index: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Searchbar Delegate Methods.
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
        
        vm.filterTableViewContent(text: searchText) { (schoolsArrayFiltered, isFiltered) in
            // Si haces lo mismo en ambos, no tiene sentido el if, simplemente llama la funcion
            if isFiltered {
                self.tableView.reloadData()
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
}
