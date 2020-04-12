//
//  ContactFormView.swift
//  Contacts
//
//  Created by Mark on 12/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import SwiftUI

struct ContactFormView: View {
    
    var didAddContact: (String, SectionType) -> () = { _,_ in }
    
    @State private var name = ""
    @State private var sectionType = SectionType.other
    
    var body: some View {
        VStack(spacing: 20) {
            
            TextField("Name", text: $name)
            
            Picker(selection: $sectionType, label: Text("Contact")) {
                Text("CEO").tag(SectionType.ceo)
                Text("Athlethe").tag(SectionType.athletes)
                Text("Celebrity").tag(SectionType.celebrities)
                Text("Other").tag(SectionType.other)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            //Add Button
            
            Button(action: {
                
                self.didAddContact(self.name, self.sectionType)
                
            }, label: {
                HStack {
                    Spacer()
                    Text("Add Contact")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(5)
            })
            
            //Cancel Button
            
            Button(action: {
                
                //Dismiss the Add Contact form
                
            }, label: {
                HStack {
                    Spacer()
                    Text("Cancel")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(5)
            })
            
            
            
            
            Spacer()
        }
        .padding()
    }
    
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormView()
    }
}
