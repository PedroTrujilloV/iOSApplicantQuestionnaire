//
//  FirebaseService.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/21/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseService {
         
    func load(with completion: @escaping (Dictionary<String,Any>,Array<String>) ->Void) {
         let dbRef = Database.database().reference()
        dbRef.child("form").observeSingleEvent(of: DataEventType.value) { (snapshot) in
           if let dict = snapshot.value as? Dictionary<String,Any> {
//                 print("\n\n\n>>>>loadFromFirebase resutl: \(dict)")
                let keys = Array(dict.keys)
                completion(dict,keys)
             } else {
               print("\n\n\n>>>>loadFromFirebase: problem loading data from firebase")
           }
         }
     }
    

     
    func update(with form:Form){
         let dbRef = Database.database().reference()
         let randN = Int.random(in: 0 ..< 2000)
         dbRef.child("form/id").setValue(randN)
        let updates: [String:Any] = ["form/fullName" : form.fullName,
                                     "form/email" : form.email,
                                       "form/projectRepo": form.projectRepo,
                                       "form/projectURL" : form.projectURL,
                                       "form/Combine" : form.combine,
                                       "form/Communication skills" : form.communication_skills,
                                       "form/Core Data" : form.core_data,
                                       "form/Debugging" : form.debugging,
                                       "form/Intelligence-Aptitude" : form.intelligence_aptitude,
                                       "form/Memory Management (ARC)" : form.memory_management_arc,
                                       "form/Modular development" : form.modular_development,
                                       "form/OOP" : form.oop,
                                       "form/Problem solving skills" : form.problem_solving_skills,
                                       "form/Self motivation" : form.self_motivation,
                                       "form/SwiftUI" : form.swiftui,
                                       "form/Testing" : form.testing,
                                       "form/UIKit" : form.uikit,
                                       "form/Working in a team" : form.workinginateam,
                                       "form/Your own energy level" : form.yourownenergylevel]
        
            dbRef.updateChildValues(updates) 
     }
    
/*
    func insert() {
         let dbRef = Database.database().reference()
         let randN = Int.random(in: 0 ..< 2000)
         dbRef.childByAutoId().setValue(["id":randN])
         
         //necessary to decode before insert
     }
    
        private func loadData() {
            let dbRef = Database.database().reference()
              dbRef.child("form").observeSingleEvent(of: DataEventType.value) { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String,Any> {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(FormDataModel.self, from: jsonData)
                        print("\n\n\n>>>>result \(result)")
                    } catch  {
                        print("\n\n\n>>>>loadData Exception: problem loading data from firebase: \(error)")
                    }
                  } else {
                    print("\n\n\n>>>>problem loading data from firebase")
                }
              }
        }
 */
    
}
