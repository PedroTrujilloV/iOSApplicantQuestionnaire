//
//  CellModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation

struct CellModel:Codable, Hashable {

    let identifier = UUID()
    let type:String
    let title:String

}