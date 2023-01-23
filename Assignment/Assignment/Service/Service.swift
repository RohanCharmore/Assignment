//
//  Service.swift
//  Assignment
//
//  Created by Swift Wizard on 24/01/23.
//

import Foundation
import UIKit

class Service {
    func fetchStudents(completion: @escaping (Result<[Student], Error>) -> Void) {
        let url = URL(string: Api.baseUrl + Api.apiKey)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            do {
                let students = try JSONDecoder().decode([Student].self, from: data)
                completion(.success(students))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


