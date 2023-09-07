//
//  DetailView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/6/23.
//

import SwiftUI

struct DetailView: View {
    @State var contact: Contact
    @State private var image: Image?
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle("\(contact.firstName) \(contact.lastName)")
        }
        .onAppear {
            if let uiimage = UIImage(data: contact.picture) {
                image = Image(uiImage: uiimage)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var contact = Contact.example
        
        NavigationView {
            DetailView(contact: contact)
        }
    }
}
