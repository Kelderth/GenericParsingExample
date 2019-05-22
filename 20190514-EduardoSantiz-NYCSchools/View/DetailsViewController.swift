//
//  DetailsViewController.swift
//  20190514-EduardoSantiz-NYCSchools
//
//  Created by Eduardo Santiz on 5/16/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var dbnLabel: UILabel!
    @IBOutlet weak var numberOfSatTestTakersLabel: UILabel!
    @IBOutlet weak var satCriticalReadingAverageScoreLabel: UILabel!
    @IBOutlet weak var satMathAverageScoreLabel: UILabel!
    @IBOutlet weak var satWritingAverageScoreLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    var schoolDetail: AditionalInformation?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Reindente tu código
        if let school = schoolDetail {
            dbnLabel.text = school.dbn
            numberOfSatTestTakersLabel.text = school.numOfSatTestTakers
            satCriticalReadingAverageScoreLabel.text = school.satCriticalReadingAvgScore
            satMathAverageScoreLabel.text = school.satMathAvgScore
            satWritingAverageScoreLabel.text = school.satWritingAvgSchore
            schoolNameLabel.text = school.schoolName
        }
    } //Y quité espacios en blanco
}
