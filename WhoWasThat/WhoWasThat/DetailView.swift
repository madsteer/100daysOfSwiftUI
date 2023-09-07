//
//  DetailView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/6/23.
//

import SwiftUI

struct DetailView: View {
    @State var person: Person
    @State private var image: Image?
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle("\(person.firstName) \(person.lastName)")
        }
        .onAppear {
            image = Image(uiImage: person.picture)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var person = Person(id: UUID(), firstName: "Steve", lastName: "Jobs", pictureFilename: "", picutre: UIImage(systemName: "star.fill")!)
        
        NavigationView {
            DetailView(person: person)
        }
    }
}
