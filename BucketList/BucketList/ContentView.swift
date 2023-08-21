//
//  ContentView.swift
//  BucketList
//
//  Created by Cory Steers on 8/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onTapGesture {
                    let str = "Test Message"
                    let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                    
                    FileManager.writeTo(url, str)
                    
                    let input = FileManager.getDocument(from: url)
                    print(input)
//                    do {
//                        try str.write(to: url, atomically: true, encoding: .utf8)
//
//                        let input = try String(contentsOf: url)
//                        print(input)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
                }
        }
        .padding()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
