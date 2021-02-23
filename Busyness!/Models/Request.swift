//
//  Request.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/28/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData


class Request: Codable {
    
    // The required fields
    var userID:     String = "" // Sender ID
    var title:      String = ""
    var body:       String = ""
    var priority:   String = ""
    var requestID:  String = ""
    
    // Everything below is for the client's convenience:
    var answer: String?
//    var timestamp: Double? = 0 // Configure this later
    var senderOriginLocation: String = "" // Configure this later
    
    var userTrail: String = "" // The history of users associated with this request
    var currentRecipient: User?
    lazy var currentStatus: ResponseStatus? = nil
    
    init(title: String, body: String, urgency: String, senderID: String, senderOriginLocation: String) {
        self.title = title
        self.body = body
        self.priority = urgency
        self.userID = senderID
        
//        self.timestamp = timestamp
        self.senderOriginLocation = senderOriginLocation
    }
    
    // Static function for using into the rest of the project.
    class func saveRequestToCoreData(question: String, urgency: Int, title: String, date: Date, Location: String, id: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RequestEntity", in: context)
        let createRequest = NSManagedObject(entity: entity!, insertInto: context)
        
        
        createRequest.setValue(id, forKey: "userID")
        createRequest.setValue(question, forKey: "question")
        createRequest.setValue(urgency, forKey: "urgency")
        createRequest.setValue(title, forKey: "title")
        createRequest.setValue(date, forKey: "date")
        createRequest.setValue(Location, forKey: "location")
        
        do {
            try context.save()
        } catch {
            print("no esta auqi")
        }
    }
    
    class func fetchRequests() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RequestEntity")
        
        do {
            return try managedContext.fetch(fetchRequest) as [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    

    func updateStatus(newStatus: ResponseStatus) {
        self.currentStatus = newStatus
    }

    func getCurrentStatus() -> ResponseStatus {
        return currentStatus ?? .error
    }
    
    func updateAnswer(answer: String) {
        self.answer = answer
    }
    
    
    enum CodingKeys: String, CodingKey {
        case userID
        case title
        case body
        case priority
    }

    enum ResponseStatus {
        case answer
        case refer
        case dontKnow
        case error
    }
}
