//
//  SchoolAditionalInformation.swift
//  20190514-EduardoSantiz-NYCSchools
//
//  Created by Eduardo Santiz on 5/14/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import Foundation

private struct SchoolAditionalInformation: Decodable {
    let schoolAditionalInformation: [AditionalInformation]
}

struct AditionalInformation: Decodable {
    let dbn: String
    let numOfSatTestTakers: String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgSchore: String
    let schoolName: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgSchore = "sat_writing_avg_score"
        case schoolName = "school_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dbn = try container.decodeIfPresent(String.self, forKey: .dbn) ?? "N/A"
        self.numOfSatTestTakers = try container.decodeIfPresent(String.self, forKey: .numOfSatTestTakers) ?? "N/A"
        self.satCriticalReadingAvgScore = try container.decodeIfPresent(String.self, forKey: .satCriticalReadingAvgScore) ?? "N/A"
        self.satMathAvgScore = try container.decodeIfPresent(String.self, forKey: .satMathAvgScore) ?? "N/A"
        self.satWritingAvgSchore = try container.decodeIfPresent(String.self, forKey: .satWritingAvgSchore) ?? "N/A"
        self.schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? "N/A"
    }
    
}
