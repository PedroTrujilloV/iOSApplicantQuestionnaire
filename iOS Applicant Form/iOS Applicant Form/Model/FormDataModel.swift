//
//  FormDataModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation

struct FormDataModel:Codable {
    let fullName:String
    let projectRepo:String
    let projectURL:String
    let skillSet: Dictionary<String,SkillModel>
}
