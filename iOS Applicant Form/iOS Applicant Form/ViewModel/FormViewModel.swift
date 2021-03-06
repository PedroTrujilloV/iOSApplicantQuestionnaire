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
    
    @ObservedObject private var coreDataService = CoreDataService()
    private var cancelable = Set<AnyCancellable>()
    private var firebaseService = FirebaseService()
    private var aCellDidChange:AnyPublisher<CellViewModel,Never> = PassthroughSubject<CellViewModel,Never>().eraseToAnyPublisher()
    
    @Published private var model = Form() {
        didSet {
            self.updateRemote()
            self.setHashTable()
        }
    }
    private var keys:Array<String> = []
    private var hashTable = Dictionary<String,Published<String>.Publisher>()

    @Published var email:String = "" {
        didSet {
            self.model.email = email
        }
    }
    @Published var fullName: String = "" {
        didSet {
            self.model.fullName = fullName
        }
    }
    @Published var projectURL: String = "" {
        didSet {
            self.model.projectURL = projectURL
        }
    }
    @Published var projectRepo: String = ""{
        didSet {
            self.model.projectRepo = projectRepo
        }
    }
    @Published var combine: String = ""{
        didSet {
            self.model.combine = Int16(combine) ?? 0 //self.model.combine
        }
    }
    @Published var communication_skills: String = ""{
        didSet {
            self.model.communication_skills = Int16(communication_skills) ?? 0 //self.model.communication_skills
        }
    }
    @Published var core_data: String = ""{
        didSet {
            self.model.core_data = Int16(core_data) ?? 0 //self.model.core_data
        }
    }
    @Published var debugging: String = ""{
        didSet {
            self.model.debugging = Int16(debugging) ?? 0 //self.model.debugging
        }
    }
    @Published var intelligence_aptitude: String = ""{
        didSet {
            self.model.intelligence_aptitude = Int16(intelligence_aptitude) ?? 0 //self.model.intelligence_aptitude
        }
    }
    @Published var memory_management_arc: String = ""{
        didSet {
            self.model.memory_management_arc = Int16(memory_management_arc) ?? 0 //self.model.memory_management_arc
        }
    }
    @Published var modular_development: String = ""{
        didSet {
            self.model.modular_development = Int16(modular_development) ?? 0 //self.model.modular_development
        }
    }
    @Published var oop: String = ""{
        didSet {
            self.model.oop = Int16(oop) ?? 0 //self.model.oop
        }
    }
    @Published var problem_solving_skills: String = ""{
        didSet {
            self.model.problem_solving_skills = Int16(problem_solving_skills) ?? 0 //self.model.problem_solving_skills
        }
    }
    @Published var self_motivation: String = ""{
        didSet {
            self.model.self_motivation = Int16(self_motivation)  ?? 0 //self.model.self_motivation
        }
    }
    @Published var swiftui: String = ""{
        didSet {
            self.model.swiftui = Int16(swiftui) ?? 0 //self.model.swiftui
        }
    }
    @Published var testing: String = ""{
        didSet {
            self.model.testing = Int16(testing) ?? 0 //self.model.testing
        }
    }
    @Published var uikit: String = ""{
        didSet {
            self.model.uikit = Int16(uikit) ?? 0 //self.model.uikit
        }
    }
    @Published var workinginateam: String = ""{
        didSet {
            self.model.workinginateam = Int16(workinginateam) ?? 0 //self.model.workinginateam
        }
    }
    @Published var yourownenergylevel: String = ""{
        didSet {
            self.model.yourownenergylevel = Int16(yourownenergylevel) ?? 0 //self.model.yourownenergylevel
        }
    }
    
    init() {
        self.coreDataService.load()
        model = coreDataService.form
        self.setHashTable()
        self.configureOutputs()

    }
    deinit {
        self.cancle()
    }
    
    func cellDidChange( sender: AnyPublisher<CellViewModel,Never> ) {
        self.aCellDidChange = sender
        aCellDidChange.setFailureType(to: Error.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
            }) {[weak self] (output) in
                let title = output.title
                self?.setFielInfo(for: title, with: output.value)
                self?.coreDataService.saveContext()
                self?.updateRemote()
        }.store(in: &cancelable)
    }
    
    func submit() {
        updateRemote()
        self.coreDataService.delete()
        model = coreDataService.form
        coreDataService.saveContext()
        self.setHashTable()
        self.configureOutputs()
    }
    
    func getFieldInfo(for title:String) -> Published<String>.Publisher?  {
        return hashTable[title]
    }

     func save(){
         self.coreDataService.saveContext()
     }
     
     func updateRemote() {
         if (!self.model.id.uuidString.isEmpty) {
             self.firebaseService.update(with: self.model)
         } else {
             print("FormViewModel.update: problem updating at Firebase model = nil")
         }
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
    
    func setFielInfo(for title:String, with text:String) {
        
        switch title {
            case "Full Name": fullName = text
            case "Email" : email = text
            case "Project Repo": projectRepo = text
            case "Project URL" : projectURL = text
            case "Combine" : combine = text
            case "Communication skills" : communication_skills = text
            case "Core Data" : core_data = text
            case "Debugging" : debugging = text
            case "Intelligence-Aptitude" : intelligence_aptitude = text
            case "Memory Management (ARC)" : memory_management_arc = text
            case "Modular development" : modular_development = text
            case "OOP" : oop = text
            case "Problem solving skills" : problem_solving_skills = text
            case "Self motivation" : self_motivation = text
            case "SwiftUI " : swiftui = text
            case "UIKit" : uikit = text
            case "Working in a team" : workinginateam = text
            case "Testing" : testing = text
            case "Your own energy level" : yourownenergylevel = text
        default:
            break
        }
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
    
    func cancle(){
        _ = cancelable.map{ $0.cancel()}

    }
}
