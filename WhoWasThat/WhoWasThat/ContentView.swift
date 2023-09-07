//
//  ContentView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var newContact: Contact?
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationView {
                List(viewModel.contacts, id: \.id) { contact in
                    NavigationLink {
                        DetailView(contact: contact)
                    } label: {
                        ContactEntryView(contact: contact)
                    }
                }
                .navigationTitle("Who was that?")
                .toolbar {
                    Button {
                        viewModel.showingAddContactScreen = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $viewModel.showingAddContactScreen) {
                    AddContactView(contact: $newContact)
                }
                .onChange(of: newContact) { _ in
                    if let newContact = newContact {
                        viewModel.save(newContact)
                    }
                }
            }
        } else {
            Button("Unlock App") {
//                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
