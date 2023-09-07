//
//  ContactEntryView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/7/23.
//

import SwiftUI

struct ContactEntryView: View {
    @State var contact: Contact
    @State var image: Image?
    
    var body: some View {
        HStack {
            image?
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            Spacer()
            
            HStack {
                Text(contact.firstName)
                
                Text(contact.lastName)
            }
            .font(.headline)
        }
        .onAppear {
            if let uiimage = UIImage(data: contact.picture) {
                image = Image(uiImage: uiimage)
            }
        }
    }
}

struct ContactEntryView_Previews: PreviewProvider {
    static var previews: some View {
        @State var contact = Contact.example
        @State var contacts = [Contact]()
        
        NavigationView {
            List(contacts, id: \.self) { cnt in
                ContactEntryView(contact: cnt)
            }
            .onAppear() { contacts.append(contact)}
        }
    }
}
