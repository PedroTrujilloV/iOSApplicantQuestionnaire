//
//  FormViewModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/21/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation

class FormViewModel:CoreDataServiceDelegate  {
    
    private let coreDataService = CoreDataService()
    private let firebaseService = FirebaseService()
    private var model:Form
        
    init() {
        model = Form()
        coreDataService.delegate = self
        load()
    }
    
    func submit() {
        coreDataService.saveContext()
    }
    
    
    func update() {
        self.model.self_motivation = Int16(Int.random(in: 40 ..< 50))
        self.model.communication_skills = Int16(Int.random(in: 40 ..< 50))
        self.firebaseService.update(with: self.model)
    }
    
    func load(){
        self.firebaseService.load { (dictionary) in
            self.coreDataService.updateFrom(from: dictionary)
            self.coreDataService.load()
        }
    }
    
    var email:String {
        return self.model.email ?? ""
    }
    
    var fullName: String {
        return self.model.fullName ?? ""
    }
    
    var projectURL: String {
        return self.model.projectURL ?? ""
    }
    
    var projectRepo: String {
        return self.model.projectRepo ?? ""
    }
    
    var combine: Int16 {
        return self.model.combine
    }
    
    var communication_skills: Int16 {
        return self.model.combine
    }
    
    var core_data: Int16 {
        return self.model.combine
    }
    
    var debugging: Int16 {
        return self.model.combine
    }
    
    var intelligence_aptitude: Int16 {
        return self.model.combine
    }
    
    var memory_management_arc: Int16 {
        return self.model.combine
    }
    
    var modular_development: Int16 {
        return self.model.combine
    }
    
    var oop: Int16 {
        return self.model.combine
    }
    
    var problem_solving_skills: Int16 {
        return self.model.combine
    }
    
    var self_motivation: Int16 {
        return self.model.combine
    }
    
    var swiftui: Int16 {
        return self.model.combine
    }
    
    var testing: Int16 {
        return self.model.combine
    }
    
    var uikit: Int16 {
        return self.model.combine
    }
    
    var workinginateam: Int16 {
        return self.model.combine
    }
    
    var yourownenergylevel: Int16 {
        return self.model.combine
    }

    // MARK: - Conform to CoreDataServiceDelegate

    func formDidLoad(form: Form) {
        self.model = form
        print("\n\n\n>>>model email: \(String(describing: model.email))\n")
//          update()
    }

}
