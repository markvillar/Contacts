//
//  ContactRowView.swift
//  Contacts
//
//  Created by Mark on 12/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import SwiftUI

struct ContactRowView: View {
    
    @ObservedObject var viewModel: ContactViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "person")
            //            KFImage(URL(string: "https://www.biography.com/.image/t_share/MTY2MzU3Nzk2OTM2MjMwNTkx/elon_musk_royal_society.jpg"))
            Text(viewModel.name)
            Spacer()
            Image(systemName: "star")
        }.padding(20)
    }
}
