//
//  CoreDataService.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/21/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    private var context:NSManagedObjectContext { return self.persistentContainer.viewContext }
    var delegate:CoreDataServiceDelegate?
    
    init(with delegate:CoreDataServiceDelegate) {
        self.delegate = delegate
        self.context.automaticallyMergesChangesFromParent = true
        _ = self.load()
    }
    init() {
        self.context.automaticallyMergesChangesFromParent = true
        _ = self.load()
    }

        
    func updateFrom(from dictionary:Dictionary<String,Any>){
        if let email = dictionary["email"] as? String {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Form")
            request.predicate = NSPredicate(format: "email = %@", email)
                if var form = try? self.context.fetch(request).first as? Form {
                    self .setForm(from: dictionary, form: &form)
                    self.saveContext()
                } else {
                    self.insertForm(from: dictionary)
                }
        }
    }
    
    private func setForm(from dictionary:Dictionary<String,Any>, form:inout Form) {
        form.email = dictionary["email"] as? String ?? ""
        form.fullName = dictionary["fullName"] as? String ?? ""
        form.projectRepo = dictionary["projectRepo"] as? String ?? ""
        form.projectURL = dictionary["projectURL"] as? String ?? ""
        form.combine = dictionary["Combine"] as? Int16 ?? 0
        form.communication_skills = dictionary["Communication skills"] as? Int16 ?? 0
        form.core_data = dictionary["Core Data"] as? Int16 ?? 0
        form.debugging = dictionary["Debugging"] as? Int16 ?? 0
        form.intelligence_aptitude = dictionary["Intelligence-Aptitude"] as? Int16 ?? 0
        form.memory_management_arc = dictionary["Memory Management (ARC)"] as? Int16 ?? 0
        form.modular_development = dictionary["Modular development"] as? Int16 ?? 0
        form.oop = dictionary["OOP"] as? Int16 ?? 0
        form.problem_solving_skills = dictionary["Problem solving skills"] as? Int16 ?? 0
        form.self_motivation = dictionary["Self motivation"] as? Int16 ?? 0
        form.swiftui = dictionary["SwiftUI"] as? Int16 ?? 0
        form.testing = dictionary["Testing"] as? Int16 ?? 0
        form.uikit = dictionary["UIKit"] as? Int16 ?? 0
        form.workinginateam = dictionary["Working in a team"] as? Int16 ?? 0
        form.yourownenergylevel = dictionary["Your own energy level"] as? Int16 ?? 0
    }
    
    func insertForm(from dictionary:Dictionary<String,Any>) {
         self.context.perform {
             let insertRequest = NSBatchInsertRequest(entity: Form.entity(), objects: [dictionary])
             _ = try? self.context.execute(insertRequest)
            self.saveContext()
         }
        _ = load()
         
     }
     
    func load(){
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Form")
//            request.predicate = NSPredicate(format: "email = %@", email)
         do {
            if let form = try self.context.fetch(request).first as? Form {
                delegate?.formDidLoad(form: form)
            }
         } catch {
             fatalError("coreDataLoad Failed to fetch Form: \(error)")
         }
     }

       private lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "iOS_Applicant_Form")
         do {
             try container.viewContext.setQueryGenerationFrom(.current)
         }catch {
             print("\n\n\n>>>> persistentContainer: problem setQueryGenerationFrom current:\n \(error)")
         }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    /**/
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
}
