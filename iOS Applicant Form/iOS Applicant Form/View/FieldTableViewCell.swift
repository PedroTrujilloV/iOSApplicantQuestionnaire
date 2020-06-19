//
//  FieldTableViewCell.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    
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
//        textField.font = UIFont(name: "MuseoSans_500", size: 12)
    }
    
}
