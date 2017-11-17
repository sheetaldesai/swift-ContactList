//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by Sheetal Desai on 11/17/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var fName : String = ""
    var lName : String = ""
    var num : String = ""
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    
    var delegate:ContactDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtFirstName.text = fName
        txtLastName.text = lName
        txtNumber.text = num
    }

    func changeBorderColor(txtField: UITextField ,color:UIColor) {
        txtField.layer.borderColor = color.cgColor
        txtField.layer.borderWidth = 1
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.dismissVC(by: self)
    }
    
    @IBAction func txtFieldEditingBegin(_ sender: UITextField) {
        changeBorderColor(txtField: sender, color: UIColor.white)
    }
    
   
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let firstName = txtFirstName.text, firstName != "" else {
            print("First Name is empty")
            changeBorderColor(txtField: txtFirstName, color: UIColor.red)
            return
        }
        guard let lastName = txtLastName.text, lastName != "" else {
            print("Last Name is empty")
            changeBorderColor(txtField: txtLastName, color: UIColor.red)
            return
        }
        guard let number = txtNumber.text, number != "" else {
            print("Last Name is empty")
            changeBorderColor(txtField: txtNumber, color: UIColor.red)
            return
        }
        
        delegate?.addContact(by: self, firstName: firstName, lastName: lastName, number: number, indexPath: indexPath)
    }
}
