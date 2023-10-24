//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/24/23.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .onTapGesture {
                selectedUser = User()
                isShowingUser.toggle()
            }
//            .sheet(item: $selectedUser) { user in
//                Text(user.id)
//            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) { }
//            }
//            .alert("Welcome", isPresented: $isShowingUser) {
//                Button("OK") { }
//            }
            .alert("Welcome", isPresented: $isShowingUser) { } // same as above.  perfect for simple alerts
    }
}

#Preview {
    ContentView()
}
