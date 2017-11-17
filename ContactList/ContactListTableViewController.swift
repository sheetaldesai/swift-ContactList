//
//  ContactListTableViewController.swift
//  ContactList
//
//  Created by Sheetal Desai on 11/17/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit
import CoreData

class ContactListTableViewController: UITableViewController {
    
    var contacts:[User] = [User]()
    
    //var contacts = [["sheetal","999-345-2343"],["vaibhavi","999-223-2345"],["Neelam","234-456-1234"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let users = ContactListModel.fetchContacts() {
            contacts = users
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].firstName! + " " + contacts[indexPath.row].lastName!
        cell.detailTextLabel?.text = contacts[indexPath.row].phNumber!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Contact Actions", message: "What would you like to do?", preferredStyle: .actionSheet)
        
        let viewButton = UIAlertAction(title: "View", style: .default, handler: { (action) -> Void in
            print("View button tapped")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "viewContactSegue", sender: indexPath)
            }
        })
        
        let editButton = UIAlertAction(title: "Edit", style: .default, handler: { (action) -> Void in
            print("Edit button tapped")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "contactDetailSegue", sender: indexPath)
            }
        })
        
        let  deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            print("Delete button tapped")
            let contact = self.contacts[indexPath.row]
            if (ContactListModel.deleteContact(contact: contact)) {
                self.contacts.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(viewButton)
        alertController.addAction(editButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetailSegue" {
            let navC = segue.destination as! UINavigationController
            let destination = navC.topViewController as! ContactDetailViewController
            destination.delegate = self
            
            if let ind = sender as? IndexPath {
                print(ind)
                let contact = contacts[ind.row]
                destination.title = "Edit Contact"
                destination.indexPath = ind
                destination.fName = contact.firstName!
                destination.lName = contact.lastName!
                destination.num = contact.phNumber!
            }
            else {
                 destination.title = "New Contact"
            }
        } else if segue.identifier == "viewContactSegue" {
            let navC = segue.destination as! UINavigationController
            let destination = navC.topViewController as! ViewContactViewController
            let ind = sender as! IndexPath
            let name = contacts[ind.row].firstName! + " " + contacts[ind.row].lastName!
            
            destination.title = contacts[ind.row].firstName!
            
            destination.delegate = self
            destination.name = name
            destination.number = contacts[ind.row].phNumber!
        }
    }
    
    // MARK: - Action Outlets
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "contactDetailSegue", sender: nil)
    }
    
}

extension ContactListTableViewController : ContactDelegate {
    func dismissVC(by controller: UIViewController) {
        print("cancel recieved")
        dismiss(animated: true, completion: nil)
    }
    
    func addContact(by controller: UIViewController, firstName: String, lastName: String, number: String, indexPath: IndexPath?) {
        dismiss(animated: true, completion: nil)
        print("\(firstName) \(lastName) \(number)")
        
        if let ind = indexPath {
            let contact = contacts[ind.row]
            contact.firstName = firstName
            contact.lastName = lastName
            contact.phNumber = number
            ContactListModel.updateContact()
        } else {
            if let contact = ContactListModel.addContact(firstName: firstName, lastName: lastName, number: number) {
                contacts.append(contact)
            }
        }
        tableView.reloadData()
    }
}
