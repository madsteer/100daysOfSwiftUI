//
//  ContentView.swift
//  iExpense
//
//  Created by Cory Steers on 4/10/23.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        Spacer()
        Spacer()
        
        Text("Hellow, \(name)!")
        
        Spacer()
        
        Button("Dismiss") {
            dismiss()
        }
        
        Spacer()
        Spacer()
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@twostraws")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
