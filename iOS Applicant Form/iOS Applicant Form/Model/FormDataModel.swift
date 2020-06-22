//
//  FormDataModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/19/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation

struct FormDataModel:Codable, Hashable {
    
    let identifier = UUID()
    let id:Int
    let fullName:String
    let email:String
    let projectRepo:String
    let projectURL:String
    
    public static func == (lhs: FormDataModel, rhs: FormDataModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
