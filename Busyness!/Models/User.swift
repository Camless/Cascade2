//
//  User.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/28/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData

class User: Encodable {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var company: String = ""
    var companyCode: String = ""
    
    var id: String? = ""
    
    var bachelorDegree: String? = ""
    var bachelorUniversity: String? = ""
    var graduateDegree: String? = ""
    var graduateUniversity: String? = ""
    
    var jobTitle: String = ""
    var yearsAtCompany: Int = 0
    var skillKeywords: [String] = []
    
    
    class func fetchUser() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error: \(error)")
            return nil
        }
    }
    
    class func returnUserID() -> String {
        let currentUser = fetchUser()
        return currentUser![0].value(forKey: "userID") as! String
    }
    
    class func saveLoggingToCoreData(validEmail: String, validPassword: String, id: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
        let User = NSManagedObject(entity: entity!, insertInto: context)
        
        User.setValue(validEmail, forKey: "email")
        User.setValue(validPassword, forKey: "password")
        User.setValue(id, forKey: "userID")
    }
    
    class func deletePreviousUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                managedContext.delete(object)
            }
            try managedContext.save()
        } catch {
            print("Error deleting Core Data objects: \(error)")
        }
    }
    
    
    class func saveUserToCoreData(newUserName:String, newUserEmail: String, newUserPassword:String,newUserCompany:String, newUserCompanyCode: String, bachelorDegree: String? = nil, bachelorUniversity: String? = nil, graduateDegree: String? = nil, graduateUniversity: String? = nil, currentJobTitle: String? = nil, yearsAtCompany: String? = nil, skillKeywords: String? = nil)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
        let Request = NSManagedObject(entity: entity!, insertInto: context)
        
        let optionalFields = [bachelorDegree, bachelorUniversity, graduateDegree, graduateUniversity, currentJobTitle, yearsAtCompany, skillKeywords] as [String?]
        
        // These must be filled
        Request.setValue(newUserName, forKey: "name")
        Request.setValue(newUserEmail, forKey: "email")
        Request.setValue(newUserPassword, forKey: "password")
        Request.setValue(newUserCompany, forKey: "company")
        Request.setValue(newUserCompanyCode, forKey: "companyCode")
        
        // Not these, so we check one by one whether or not they're filled.
        for field in optionalFields {
            if field != "" && field != nil {
                print(field as String!)
                Request.setValue(field, forKey: String(field!))
            }
        }
        
        do {
            try context.save()
        } catch {
            print("no esta auqi")
        }
    }

    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case password
        case company
        case companyCode
        
        case bachelorDegree = "bachelorDeg"
        case bachelorUniversity = "bachelorUniv"
        case graduateDegree = "masterDeg"
        case graduateUniversity = "masterUniv"
        
        case jobTitle = "currentJobTitle"
        case yearsAtCompany
        case skillKeywords = "keywords"
    }
    
}
