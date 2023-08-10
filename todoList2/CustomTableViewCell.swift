//
//  CustomTableViewCell.swift
//  todoList2
//
//  Created by 정동교 on 2023/08/11.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var customSwitch: UISwitch!
    @IBOutlet weak var customLable: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customLable.attributedText = nil
        dateLabel.attributedText = nil
        dateLabel.textColor = .black
    }
}
