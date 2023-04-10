//
//  ContentView.swift
//  iExpense
//
//  Created by Cory Steers on 4/10/23.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
//    @State private var user = User() // if User was a struct
    @StateObject var user = User() // if User is a class

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)

            TextField("Last name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
