//
//  ContentView.swift
//  FriendFace
//
//  Created by Cory Steers on 7/27/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var users = [User]()
//    @StateObject var viewModel = UserDataModel()
//    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    private let urlString = "http://127.0.0.1:8085/friendface.json"
    
    var body: some View {
        NavigationView {
            ForEach(users, id: \.self) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    Text(user.name)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(user.isActive ? .green : .red)
                }
            }
            .task {
//                await viewModel.fetchUsers(using: moc)
                await loadData()
            }
            .navigationTitle("Friend Face")
        }
    }
    
    func loadData() async {
        print("got into loadData() ...")
        guard users.isEmpty else { return }
        
        guard let url = URL(string: urlString) else {
            print("Invalid url: '\(urlString)'")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
//                let fetchedUsers = decodedData
                users = decodedData
                
//                await MainActor.run {
//                    fetchedUsers.forEach { f in
//                        let user = CachedUser(context: moc)
//                        moc.perform {
//                            user.id = f.id
//                            user.about = f.about
//                            user.address = f.address
//                            user.age = Int16(f.age)
//                            user.company = f.company
//                            user.email = f.email
//
//                            f.friends.forEach({ fetchedFriend in
//                                let friend = CachedFriend(context: moc)
//                                friend.id = fetchedFriend.id
//                                friend.name = fetchedFriend.name
//                            })
//
//                            user.name = f.name
//                            user.registered = f.registered
//                            user.tags = f.tags.joined(separator: ",")
//                        }
//                    }
//
//                    try? moc.save()
//                }
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
