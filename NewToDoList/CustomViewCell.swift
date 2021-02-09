//
//  CustomViewCell.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var taskID: String!
    
    var delegate: CheckBoxListener?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func checkButtonTappet(_ sender: Any) {
        guard taskID != nil else { return }
        delegate?.checkButtonTapped(cell: self)
        print("check box on task with id:\(String(taskID)) tapped")
    }
    
    func bind(task: Task) {
        titleLabel.text = task.title
        detailsLabel.text = task.details
        taskID = task.id
        let image = UIImage(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
        checkButton.setImage(image, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
