//
//  ContactListModel.swift
//  ContactList
//
//  Created by Sheetal Desai on 11/17/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContactListModel {
    
    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func fetchContacts() -> [User]? {
        print("fetchContacts")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let results = try (managedObjectContext.fetch(request))
            print("Got results")
            return results as! [User]
        } catch {
            print("\(error)")
        }
        return nil
    }
    
    static func addContact(firstName:String, lastName: String, number: String) -> User? {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as! User
        user.firstName = firstName
        user.lastName = lastName
        user.phNumber = number
        do {
            try managedObjectContext.save()
            return user
        } catch {
            print("\(error)")
        }
        return nil
    }
    
    static func updateContact() {
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }
    
    static func deleteContact(contact:User) -> Bool {
        
        managedObjectContext.delete(contact)
        do {
            try managedObjectContext.save()
            print("Success")
            return true
        } catch {
            print("\(error)")
        }
        
        return false
    }
}
