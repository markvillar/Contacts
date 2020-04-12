//
//  ContactRowView.swift
//  Contacts
//
//  Created by Mark on 12/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ContactRowView: View {
    
    @ObservedObject var viewModel: ContactViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: viewModel.image))
                .renderingMode(.original)
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                .shadow(radius: 0.5)
            
            Text(viewModel.name)
            Spacer()
            Image(systemName: viewModel.isFavourite ? "star.fill" : "star")
        }.padding(20)
    }
}
