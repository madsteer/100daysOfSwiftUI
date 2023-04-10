//
//  ContentView.swift
//  iExpense
//
//  Created by Cory Steers on 4/10/23.
//

import SwiftUI



struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                    /*
                     could also just do
                     List(numbers, id: \.self) {
                     Text("Row \($0)")
                     }
                     here but .onDelete needs the 'ForEach" to work
                     */
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
