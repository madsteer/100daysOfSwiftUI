//
//  ContentView.swift
//  FriendFace
//
//  Created by Cory Steers on 7/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
//    private let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    private let urlString = "http://127.0.0.1:8085/friendface.json"

    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                VStack {
                        Text(user.name)
                            .font(.headline)
                        
                        Text("Number of friends: \(user.friends.count)")
                        .font(.callout)
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Face Friend")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: urlString) else {
            print("Invalid url: '\(urlString)'")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedData
            }
        } catch {
            print("URL call failed: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
