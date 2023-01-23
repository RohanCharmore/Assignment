//
//  StudentsViewController.swift
//  Assignment
//
//  Created by Swift Wizard on 24/01/23.
//

import UIKit

class StudentsViewController: UIViewController {
    
    private var viewModel = StudentViewModel(service: Service())
    private var students: [Student] = []
    
    
    //MARK: - @IBOutlet

    @IBOutlet weak var listTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewCell()
        getStudentList()
    }
    
    //MARK: - Setup TableViewCell

    func setupTableViewCell(){
        
        listTableView.register(UINib(nibName: CellNibName.StudentsTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.StudentsTableViewCell)
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = 240
    }
    
    //MARK: - Api Call
    func getStudentList(){
        viewModel.fetchStudents { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let students):
                self.students = students
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: - UITableViewDataSource

extension StudentsViewController : UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.numberOfStudents()
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsTableViewCell", for: indexPath) as? StudentsTableViewCell else { return UITableViewCell() }
        let student = viewModel.student(at: indexPath.row)

         cell.configure(name: student.name, university: student.university, gpa: student.gpa, skills: student.skills, isShortlisted: student.isShortlisted)
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    
    
    
}

//MARK: - UITableViewDelegate

extension StudentsViewController : UITableViewDelegate {
    
    //MARK: - viewForHeaderInSection setup header title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.init(x: 2, y: 2, width: headerView.frame.width-10, height: headerView.frame.height - 4)
        titleLabel.text = "Swift Student Challenge"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    //MARK: - heightForHeaderInSection setup header height

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //MARK: - heightForRowAt setup row height

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableView.automaticDimension
    }

     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
      return 240
    }
    
}

//MARK: - StudentsTableViewDelegate delegate 
extension StudentsViewController : StudentsTableViewDelegate {
    func didTapShortlistButton(at index: Int,  cell: StudentsTableViewCell) {
   
        let student = viewModel.student(at: index)
            viewModel.toggleShortlist(for: student)
        
        if student.isShortlisted {
            cell.shortlistButton.setTitle("Shortlist", for: .normal)
            cell.shortlistButton.backgroundColor = .blue
        } else {
            cell.shortlistButton.setTitle("Shortlisted", for: .normal)
            cell.shortlistButton.backgroundColor = .lightGray
            
            let alertController = UIAlertController(title: "Shortlisted", message: "\(student.name) has been shortlisted", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
          }
        }
}
    
