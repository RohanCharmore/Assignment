//
//  StudentsTableViewCell.swift
//  Assignment
//
//  Created by Swift Wizard on 24/01/23.
//


import UIKit

protocol StudentsTableViewDelegate: AnyObject {
    func didTapShortlistButton(at index: Int ,cell: StudentsTableViewCell)
}


class StudentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var shortlistButton: UIButton!
    
    var delegate: StudentsTableViewDelegate?
    var index: Int!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Configure UI
    func configure(name: String?, university: String?, gpa: Double, skills: String?,isShortlisted:Bool?) {
      
        nameLabel.text = name ?? Keywords.notFound
        universityLabel.text = university ?? Keywords.notFound
        gpaLabel.text = String(format: "%.2f", gpa )
        skillsLabel.text = skills ?? Keywords.notFound
        
        shortlistButton.addTarget(self, action: #selector(shortlistButtonTapped), for: .touchUpInside)
    }
    
    @objc func shortlistButtonTapped() {
        delegate?.didTapShortlistButton(at: index, cell: self)
    }
    
}
