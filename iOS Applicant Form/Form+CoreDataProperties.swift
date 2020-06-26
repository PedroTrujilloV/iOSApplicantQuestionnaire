//
//  Form+CoreDataProperties.swift
//  iOS Applicant Form
//
//  Created by Pedro Trujillo on 6/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//
//

import Foundation
import CoreData


extension Form {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Form> {
        return NSFetchRequest<Form>(entityName: "Form")
    }

    @NSManaged public var combine: Int16
    @NSManaged public var communication_skills: Int16
    @NSManaged public var core_data: Int16
    @NSManaged public var debugging: Int16
    @NSManaged public var email: String
    @NSManaged public var fullName: String
    @NSManaged public var id: UUID
    @NSManaged public var intelligence_aptitude: Int16
    @NSManaged public var memory_management_arc: Int16
    @NSManaged public var modular_development: Int16
    @NSManaged public var oop: Int16
    @NSManaged public var problem_solving_skills: Int16
    @NSManaged public var projectRepo: String
    @NSManaged public var projectURL: String
    @NSManaged public var self_motivation: Int16
    @NSManaged public var swiftui: Int16
    @NSManaged public var testing: Int16
    @NSManaged public var uikit: Int16
    @NSManaged public var workinginateam: Int16
    @NSManaged public var yourownenergylevel: Int16

}
