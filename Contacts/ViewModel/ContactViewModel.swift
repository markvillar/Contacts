//
//  ContactViewModel.swift
//  Contacts
//
//  Created by Mark on 12/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import Foundation

class ContactViewModel: ObservableObject {
    @Published var name = ""
    @Published var image = ""
}
