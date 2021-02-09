//
//  TaskViewCell.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import UIKit

protocol TaskViewCellDelegate {
    func checkBoxTapped(cell: TaskViewCell)
}

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var taskID: String!
    
    var delegate: TaskViewCellDelegate?

    @IBAction func checkButtonTappet(_ sender: Any) {
        guard taskID != nil else { return }
        delegate?.checkBoxTapped(cell: self)
        print("check box on task with id:\(String(taskID)) tapped")
    }
    
    func bind(task: Task) {
        titleLabel.text = task.title
        detailsLabel.text = task.details
        
        let image = UIImage(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
        checkButton.setImage(image, for: .normal)
        
        taskID = task.id
    }
    
}
