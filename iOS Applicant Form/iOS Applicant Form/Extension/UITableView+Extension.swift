//
//  UITableView+Extension.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/27/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
