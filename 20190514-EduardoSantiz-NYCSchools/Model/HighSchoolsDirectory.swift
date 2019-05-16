//
//  HighSchoolsDirectory.swift
//  20190514-EduardoSantiz-NYCSchools
//
//  Created by Eduardo Santiz on 5/14/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import Foundation

private struct HighSchoolsDirectory: Decodable {
    let highSchoolsDirectory: [HighSchools]
}

struct HighSchools: Decodable {
    let dbn: String
    let location: String
    let neighborhood: String
    let phoneNumber: String
    let schoolEmail: String
    let schoolName: String
    let totalStudents: String
    let website: String
    let zip: String
    
    enum CodingKeys: String, CodingKey {
        case dbn, location, neighborhood, website, zip
        case phoneNumber = "phone_number"
        case schoolEmail = "school_email"
        case schoolName = "school_name"
        case totalStudents = "total_students"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dbn = try container.decodeIfPresent(String.self, forKey: .dbn) ?? "N/A"
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? "N/A"
        self.neighborhood = try container.decodeIfPresent(String.self, forKey: .neighborhood) ?? "N/A"
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? "N/A"
        self.schoolEmail = try container.decodeIfPresent(String.self, forKey: .schoolEmail) ?? "N/A"
        self.schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? "N/A"
        self.totalStudents = try container.decodeIfPresent(String.self, forKey: .totalStudents) ?? "N/A"
        self.website = try container.decodeIfPresent(String.self, forKey: .website) ?? "N/A"
        self.zip = try container.decodeIfPresent(String.self, forKey: .zip) ?? "N/A"
    }
}
