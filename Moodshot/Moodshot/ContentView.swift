//
//  ContentView.swift
//  Moodshot
//
//  Created by Cory Steers on 4/20/23.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            print("decode button pressed")
            let input = """
            {
                "name": "Taylor Swift",
                "address":  {
                    "street": " 555 Taylor Swift Ave",
                    "city": "Nashville"
                }
            }
            """
            let data = Data(input.utf8)
//            do {
//                let user = try JSONDecoder().decode(User.self, from: data)
//                print(user.address.street)
//            } catch {
//                print("some kind of error: \(error)")
//            }
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
