//
//  ContactCell.swift
//  Contacts
//
//  Created by Mark on 10/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import SwiftUI
import LBTATools
import KingfisherSwiftUI

class ContactCell: UITableViewCell {
    
    let viewModel = ContactViewModel()
    
    lazy var row = ContactRowView(viewModel: viewModel)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let hostingController = UIHostingController(rootView: row)
        
        addSubview(hostingController.view)
        hostingController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
