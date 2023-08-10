//
//  ContentView.swift
//  FriendFace
//
//  Created by Cory Steers on 7/27/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
//    private let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    private let urlString = "http://127.0.0.1:8085/friendface.json"
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    Text(user.wrappedName)
                        .font(.headline)
                    Spacer()
                    Text("\(user.friendArray.count)")
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(user.isActive ? .green : .red)
                }
            }
            .task {
                await loadData()
            }
            
        }
        .navigationTitle("Friend Face")
    }
    
    func loadData() async {
        guard users.isEmpty else { return }
        
        guard let url = URL(string: urlString) else {
            print("Invalid url: '\(urlString)'")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
                let fetchedUsers = decodedData
                
                await MainActor.run {
                    fetchedUsers.forEach { f in
                        let user = CachedUser(context: moc)
                        user.id = f.id
                        user.about = f.about
                        user.address = f.address
                        user.age = Int16(f.age)
                        user.company = f.company
                        user.email = f.email
                        
                        print("user \(f.name) has \(f.friends.count) friends")
                        if (f.friends.count > 0) {
                            print("user \(f.name)'s first friend is \(f.friends[0].name)")
                        }
                        
                        f.friends.forEach({ fetchedFriend in
                            let friend = CachedFriend(context: moc)
                            friend.id = fetchedFriend.id
                            friend.name = fetchedFriend.name
                            user.addToFriend(friend)
                        })
                        
                        user.name = f.name
                        user.registered = f.registered
                        user.tags = f.tags.joined(separator: ",")
                    }

                    try? moc.save()
                }
            }
        } catch {
            print("URL call failed: \(error)")
        }
    }
}

// preview keeps crashing for some reason
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
