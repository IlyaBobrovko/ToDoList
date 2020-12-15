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
    
    var delegate: CustomCellListener?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(task: Task) {
        titleLabel.text = task.title
        detailsLabel.text = task.details
    }
    @IBAction func checkButtonTappet(_ sender: Any) {
        delegate?.checkButtonTapped(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
