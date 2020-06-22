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
    private var keys:Array<String> = []
    
    init() {
        model = Form()
        coreDataService.delegate = self
        
        load()
    }
    
    func submit() {
        coreDataService.saveContext()
    }
    
    
    func update() {
        self.model.self_motivation = Int16(Int.random(in: 40 ..< 50)) //delete
        self.model.communication_skills = Int16(Int.random(in: 40 ..< 50)) //delete
        self.firebaseService.update(with: self.model)
    }
    
    func load(){
        self.firebaseService.load { (dictionary,keys) in
            self.keys = keys
            self.coreDataService.updateFrom(from: dictionary)
            self.coreDataService.load()
        }
    }
    
    func formFieldInfoFrom(title:String) ->String {
        
        let hashTable = ["Full Name" : fullName,
        "Email" : email,
          "Project Repo": projectRepo,
          "Project URL" : projectURL,
          "Combine" : combine,
          "Communication skills" : communication_skills,
          "Core Data" : core_data,
          "Debugging" : debugging,
          "Intelligence-Aptitude" : intelligence_aptitude,
          "Memory Management (ARC)" : memory_management_arc,
          "Modular development" : modular_development,
          "OOP" : oop,
          "Problem solving skills" : problem_solving_skills,
          "Self motivation" : self_motivation,
          "SwiftUI " : swiftui,
          "Testing" : testing,
          "UIKit" : uikit,
          "Working in a team" : workinginateam,
          "Your own energy level" : yourownenergylevel]
            
        
        return hashTable[title] ?? ""
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
    
    var combine: String {
        return String(self.model.combine)
    }
    
    var communication_skills: String {
        return String(self.model.communication_skills)
    }
    
    var core_data: String {
        return String(self.model.core_data)
    }
    
    var debugging: String {
        return String(self.model.debugging)
    }
    
    var intelligence_aptitude: String {
        return String(self.model.intelligence_aptitude)
    }
    
    var memory_management_arc: String {
        return String(self.model.memory_management_arc)
    }
    
    var modular_development: String {
        return String(self.model.modular_development)
    }
    
    var oop: String {
        return String(self.model.oop)
    }
    
    var problem_solving_skills: String {
        return String(self.model.problem_solving_skills)
    }
    
    var self_motivation: String {
        return String(self.model.self_motivation)
    }
    
    var swiftui: String {
        return String(self.model.swiftui)
    }
    
    var testing: String {
        return String(self.model.testing)
    }
    
    var uikit: String {
        return String(self.model.uikit)
    }
    
    var workinginateam: String {
        return String(self.model.workinginateam)
    }
    
    var yourownenergylevel: String {
        return String(self.model.yourownenergylevel)
    }

    // MARK: - Conform to CoreDataServiceDelegate

    func formDidLoad(form: Form) {
        self.model = form
        print("\n\n\n>>>model email: \(String(describing: model.email))\n")
//          update()
    }

}
