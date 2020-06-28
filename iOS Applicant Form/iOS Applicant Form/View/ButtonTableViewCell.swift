//
//  ButtonTableViewCell.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    private var cellVM:CellViewModel!
    private var cancelable:AnyCancellable?

    static let reuseIdentifer = "ButtonTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setViewModel(cellVM:CellViewModel) {
        self.cellVM = cellVM
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
