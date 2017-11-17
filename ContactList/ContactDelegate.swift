//
//  ContactDelegate.swift
//  ContactList
//
//  Created by Sheetal Desai on 11/17/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol ContactDelegate {
    func dismissVC(by controller: UIViewController)
    func addContact(by controller: UIViewController, firstName:String, lastName:String, number:String, indexPath: IndexPath?)
}
