//
//  Contact.swift
//  Contacts
//
//  Created by Mark on 12/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import Foundation

class Contact: NSObject {
    let name: String
    let image: String
    var isFavourite: Bool = false
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
