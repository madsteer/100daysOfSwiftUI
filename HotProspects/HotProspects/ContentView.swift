//
//  ContentView.swift
//  HotProspects
//
//  Created by Cory Steers on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var output = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(output)
                .task {
                    await fetchReadings()
                }
        }
        .padding()
    }
    
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
//        do {
//            output = try result.get()
//        } catch {
//            print(("Download error: \(error.localizedDescription)"))
//        }
        
        // OR
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Download error \(error.localizedDescription)"
        }
    }
    
    func fetchReadingsOriginal() async {
        do {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            output = "Found \(readings.count) readings"
        } catch {
            print(("Download error: \(error.localizedDescription)"))
        }
    }
}

#Preview {
    ContentView()
}
