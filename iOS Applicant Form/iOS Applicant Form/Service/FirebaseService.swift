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
        dbRef.child(" make the form id here").observeSingleEvent(of: DataEventType.value) { (snapshot) in
           if let dict = snapshot.value as? Dictionary<String,Any> {
                let keys = Array(dict.keys)
                completion(dict,keys)
             } else {
               print("\n\n\n>>>>loadFromFirebase: problem loading data from firebase")
           }
         }
     }
     
    func update(with form:Form){
         let dbRef = Database.database().reference()
        let updates: [String:Any] = makeUpdates(with: form)
        dbRef.updateChildValues(updates)
     }
    
    func makeUpdates(with form:Form) ->[String:Any] {
        return  ["\(String(describing: form.id))/ts" : form.ts.timeIntervalSince1970,
                 "\(String(describing: form.id))/fullName" : form.fullName ,
                 "\(String(describing: form.id))/email" : form.email ,
                 "\(String(describing: form.id))/projectRepo": form.projectRepo ,
                 "\(String(describing: form.id))/projectURL" : form.projectURL ,
          "\(String(describing: form.id))/Combine" : form.combine,
          "\(String(describing: form.id))/Communication skills" : form.communication_skills,
          "\(String(describing: form.id))/Core Data" : form.core_data,
          "\(String(describing: form.id))/Debugging" : form.debugging,
          "\(String(describing: form.id))/Intelligence-Aptitude" : form.intelligence_aptitude,
          "\(String(describing: form.id))/Memory Management (ARC)" : form.memory_management_arc,
          "\(String(describing: form.id))/Modular development" : form.modular_development,
          "\(String(describing: form.id))/OOP" : form.oop,
          "\(String(describing: form.id))/Problem solving skills" : form.problem_solving_skills,
          "\(String(describing: form.id))/Self motivation" : form.self_motivation,
          "\(String(describing: form.id))/SwiftUI" : form.swiftui,
          "\(String(describing: form.id))/Testing" : form.testing,
          "\(String(describing: form.id))/UIKit" : form.uikit,
          "\(String(describing: form.id))/Working in a team" : form.workinginateam,
          "\(String(describing: form.id))/Your own energy level" : form.yourownenergylevel]
    }
    
}
