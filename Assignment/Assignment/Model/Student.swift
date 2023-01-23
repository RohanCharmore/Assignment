//
//  Student.swift
//  Assignment
//
//  Created by Swift Wizard on 24/01/23.
//

import Foundation

//MARK: - Modal

struct Student: Decodable {
    var name: String
    let university: String
    let gpa: Double
    let skills: String
    var isShortlisted: Bool = false

    
    private enum CodingKeys: String, CodingKey {
        case name, university, gpa, skills
    }
}
