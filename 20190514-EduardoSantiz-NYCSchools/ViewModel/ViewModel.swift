//
//  ViewModel.swift
//  20190514-EduardoSantiz-NYCSchools
//
//  Created by Eduardo Santiz on 5/14/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import Foundation

class ViewModel {
    let ns = NetworkService() //Renombrar a networkService, hacer nombres mas significativos
    
    private static let baseURL = "https://data.cityofnewyork.us/resource/"
    
    let directoryBaseURL = ViewModel.baseURL + "s3k6-pzi2.json"
    let schoolDetailsURL = ViewModel.baseURL + "f9bf-2cp4.json"
    
    private var highSchools: [HighSchools]?
    private var aditionalInformation: [AditionalInformation]?
    
    private var schoolsDirectory: [HighSchools] = [HighSchools]()
    private var schoolsDirectoryBackup: [HighSchools] = [HighSchools]()
    private var schoolsDetails: [AditionalInformation] = [AditionalInformation]()
    
    func downloadData<T: Decodable> (modelName: T.Type, completion: @escaping () -> Void) {
        let baseURL = modelName == [HighSchools].self ? directoryBaseURL : schoolDetailsURL
        
        ns.download(fromURL: baseURL) { (data) in
            guard let jsonData = data else {
                completion()
                return
            }

            let model = try? JSONDecoder().decode(modelName.self, from: jsonData)

            switch baseURL {
            case self.directoryBaseURL:
                self.highSchools = model as? [HighSchools]
                completion()
            case self.schoolDetailsURL:
                self.aditionalInformation = model as? [AditionalInformation]
                completion()
            default:
                fatalError("No valid model was picked.")
            }
        }
    }

    func setArray<T: Decodable>(from model: T.Type) {
        if model == [HighSchools].self {
            self.schoolsDirectory = highSchools ?? []
            self.schoolsDirectoryBackup = self.schoolsDirectory
        } else {
            self.schoolsDetails = aditionalInformation ?? []
        }
    }
    
    func getArrayOfHighschools() -> [HighSchools] {
        return self.highSchools ?? []
    }

    func getNumberOfItemsInArray<T: Decodable>(fromModel model: T.Type) -> Int {
        if model == [HighSchools].self {
            return self.schoolsDirectory.count
        }
        return self.schoolsDetails.count
    }
    
    func getSchoolName<T: Decodable>(fromModel model: T.Type, index: Int) -> String {
        if model == [HighSchools].self {
            return self.schoolsDirectory[index].schoolName
        }
        return self.schoolsDetails[index].schoolName
    }
    
    func getSchoolLocation(index: Int) -> String {
        return self.schoolsDirectory[index].location
    }
    
    func schoolHasDetails(index: Int) -> Bool {
        let schoolDetail = schoolsDetails.filter({$0.dbn == schoolsDirectory[index].dbn })
        
        let hasDetails = schoolDetail.isEmpty ? false : true
        
        return hasDetails
    }
    
    func getSchoolDetails(index: Int) -> AditionalInformation? {
        let schoolDetail = schoolsDetails.filter({$0.dbn == schoolsDirectory[index].dbn })

        if schoolDetail.isEmpty { return nil } else { return schoolDetail[0] }
    }
    
    func filterTableViewContent(text: String, completion: @escaping ([HighSchools?],Bool) -> Void) {
        var searchTermsFiltered: [HighSchools]?
        
        searchTermsFiltered = schoolsDirectoryBackup.filter({$0.schoolName.contains(text)})
        
        if !searchTermsFiltered!.isEmpty && !text.isEmpty {
            schoolsDirectory = searchTermsFiltered! //No hagas force unwrapping
            
            completion(schoolsDirectory, true)
        } else {
            schoolsDirectory = schoolsDirectoryBackup
            completion(schoolsDirectory, false)
        }
    }
}
