//
//  StudentViewModel.swift
//  Assignment
//
//  Created by Swift Wizard on 24/01/23.
//

import Foundation

// ViewModel
class StudentViewModel {
    private var students: [Student]
    private var service: Service

    init(service: Service) {
        self.service = service
        self.students = []
    }

    func fetchStudents(completion: @escaping (Result<[Student], Error>) -> Void) {
        service.fetchStudents { result in
            switch result {
            case .success(let students):
                self.students = students
                completion(.success(students))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfStudents() -> Int {
        return  students.count
    }

    func student(at index: Int) -> Student {
        return students[index]
    }

    func toggleShortlist(for student: Student) {
        if let index = students.firstIndex(where: { $0.name == student.name }) {
            var updatedStudent = student
            updatedStudent.isShortlisted = !student.isShortlisted
            students[index] = updatedStudent
        }
    }
}
