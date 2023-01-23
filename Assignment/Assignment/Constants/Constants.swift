//
//  Constants.swift
//  Assignment
//
//  Created by Swift Wizard on 24/01/23.
//

import Foundation

//MARK: - Constants

enum Api {
    static let baseUrl = "https://run.mocky.io/v3/"
    static let apiKey = "1f279003-f26e-4af9-8e34-f0f2b82c7f13"
}

enum ApiError: Error {
    case noData
    case serverError(Error)
    case invalidResponse
    case decodingError(Error)
}


enum CellNibName {
    static let StudentsTableViewCell = "StudentsTableViewCell"
}


enum CellIdentifier {
    static let StudentsTableViewCell = "StudentsTableViewCell"
}

enum Keywords {
    static let notFound = "N/A"
}


