//
//  FormViewModel.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/21/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class FormViewModel:ObservableObject  {
    
    @Published private var coreDataService = CoreDataService()
    private var cancelable:AnyCancellable?
    private var firebaseService = FirebaseService()
    @Published private var model = Form() {
        didSet {
            self.update()
            self.setHashTable()
        }
    }
    private var keys:Array<String> = []
    private var hashTable = Dictionary<String,Published<String>.Publisher>()
    
    @Published var email:String = ""
    @Published var fullName: String = ""
    @Published var projectURL: String = ""
    @Published var projectRepo: String = ""
    @Published var combine: String = ""
    @Published var communication_skills: String = ""
    @Published var core_data: String = ""
    @Published var debugging: String = ""
    @Published var intelligence_aptitude: String = ""
    @Published var memory_management_arc: String = ""
    @Published var modular_development: String = ""
    @Published var oop: String = ""
    @Published var problem_solving_skills: String = ""
    @Published var self_motivation: String = ""
    @Published var swiftui: String = ""
    @Published var testing: String = ""
    @Published var uikit: String = ""
    @Published var workinginateam: String = ""
    @Published var yourownenergylevel: String = ""
    
    init() {
        
        self.coreDataService.load()
        model = coreDataService.form
        self.configureOutputs()
    }
    
    func submit() {
        coreDataService.saveContext()
    }
    
    func setHashTable(){
        self.hashTable =  ["Full Name" : $fullName,
                           "Email" : $email,
          "Project Repo": $projectRepo,
          "Project URL" : $projectURL,
          "Combine" : $combine,
          "Communication skills" : $communication_skills,
          "Core Data" : $core_data,
          "Debugging" : $debugging,
          "Intelligence-Aptitude" : $intelligence_aptitude,
          "Memory Management (ARC)" : $memory_management_arc,
          "Modular development" : $modular_development,
          "OOP" : $oop,
          "Problem solving skills" : $problem_solving_skills,
          "Self motivation" : $self_motivation,
          "SwiftUI " : $swiftui,
          "UIKit" : $uikit,
          "Working in a team" : $workinginateam,
          "Testing" : $testing,
          "Your own energy level" : $yourownenergylevel] as Dictionary<String,Published<String>.Publisher>
    }
    
    
    func update() {
        if (!self.model.id.uuidString.isEmpty) {
            self.firebaseService.update(with: self.model)
        } else {
            print("FormViewModel.update: problem updating at Firebase model = nil")
        }
    }

    
//    func load(){
//        self.firebaseService.load { (dictionary,keys) in
//            self.keys = keys
//            self.coreDataService.updateFrom(from: dictionary)
//            self.coreDataService.load()
//        }
//    }
    
    func formFieldInfoFrom(title:String) ->Published<String>.Publisher?  {
        return hashTable[title]
    }
        
    func configureOutputs(){
        email = getEmail()
        fullName = getFullName()
        projectURL = getProjectURL()
        projectRepo = getProjectRepo()
        combine = getCombine()
        communication_skills = getCommunication_skills()
        core_data = getCore_data()
        debugging = getDebugging()
        intelligence_aptitude = getIntelligence_aptitude()
        memory_management_arc = getMemory_management_arc()
        modular_development = getModular_development()
        oop = getOOP()
        problem_solving_skills = getProblem_solving_skills()
        self_motivation = getSelf_motivation()
        swiftui = getSwiftui()
        workinginateam = getWorkinginateam()
        yourownenergylevel = getYourownenergylevel()
        testing = getTesting()
        uikit = getUIKit()
        
        print("\n\n\n\n>>>> FormViewModel.fullName: \(String(describing: self.fullName))")
    }
    
    private func getEmail() ->String{
        return self.model.email
    }
    
    private func getFullName() ->String{
        return self.model.fullName
    }
    
    private func getProjectURL() ->String{
        return self.model.projectURL
    }
    
    private func getProjectRepo() ->String{
        return self.model.projectRepo
    }
    
    private func getCombine() ->String{
        return String(describing: self.model.combine)
    }
    
    private func getCommunication_skills() ->String{
        return String(describing:self.model.communication_skills)
    }
    
    private func getCore_data() ->String{
        return String(describing:self.model.core_data)
    }
    
    private func getDebugging() ->String{
        return String(describing:self.model.debugging)
    }
    
    private func getIntelligence_aptitude() ->String{
        return String(describing:self.model.intelligence_aptitude)
    }
    
    private func getMemory_management_arc() ->String{
        return String(describing:self.model.memory_management_arc)
    }
    
    private func getModular_development() ->String{
        return String(describing:self.model.modular_development)
    }
    
    private func getOOP() ->String{
        return String(describing:self.model.oop)
    }
    
    private func getProblem_solving_skills() ->String{
        return String(describing:self.model.problem_solving_skills)
    }
    
    private func getSelf_motivation() ->String{
        return String(describing:self.model.self_motivation)
    }
    
    private func getSwiftui() ->String{
        return String(describing:self.model.swiftui)
    }
    
    private func getTesting() ->String{
        return String(describing:self.model.testing)
    }
    
    private func getUIKit() ->String{
        return String(describing:self.model.uikit)
    }
    
    private func getWorkinginateam() ->String{
        return String(describing:self.model.workinginateam)
    }
    
    private func getYourownenergylevel() ->String{
        return String(describing:self.model.yourownenergylevel)
    }


}
