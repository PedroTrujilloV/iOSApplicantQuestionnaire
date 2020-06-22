//
//  LabelAndFieldTableViewCell.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit

class LabelAndFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    static let reuseIdentifer = "LabelAndFieldTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }
    private func setup(){
        configureStyle()
    }
    private func configureStyle(){
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont(name: "MuseoSans-500", size: 15)
        title.font = UIFont(name: "MuseoSans-500", size: 15)
    }
}
