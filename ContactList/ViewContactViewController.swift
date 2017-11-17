//
//  ViewContactViewController.swift
//  ContactList
//
//  Created by Sheetal Desai on 11/17/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

class ViewContactViewController: UIViewController {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    var name = ""
    var number = ""
    var delegate:ContactDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = name
        lblNumber.text = number
    }

  
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.dismissVC(by: self)
    }
    

    

}
