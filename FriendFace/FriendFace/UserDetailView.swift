//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Cory Steers on 7/27/23.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    
    var body: some View {
        List {
            Section {
                Text("id: \(user.id)")
                Text("age: \(user.age)")
                Text("company: \(user.company)")
                Text("email: \(user.email)")
            }
            
            Section(header: Text("Address")) {
                Text(user.address)
            }
            
            Section {
                Text(user.about)
            }
            
            Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            
            Section(header: Text("Friends")) {
                ForEach(user.friends, id: \.self) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let friend1 = Friend(id: "12345", name: "John Doe")
        let friend2 = Friend(id: "45678", name: "Jill Doe")
        let user = User(
            id: "123",
            isActive: false,
            name: "Jose Quervo",
            age: 21,
            company: "Acme",
            email: "user@domain.com",
            address: "123 Melody Lane",
            about: "Successfull blah blah blah.  Who gives a hoot.",
            registered: "yes",
            tags: ["husband", "father"],
            friends: [friend1, friend2]
        )
        NavigationView {
            UserDetailView(user: user)
        }
    }
}
