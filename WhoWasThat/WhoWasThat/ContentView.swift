//
//  ContentView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationView {
                List(viewModel.persons, id: \.id) { person in
                    NavigationLink {
                        DetailView(person: person)
                    } label: {
                        HStack {
                            Image(uiImage: person.picture)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            
                            Spacer()
                            
                            HStack {
                                Text(person.firstName)
                                    .font(.headline)
                                
                                Text(person.lastName)
                            }
                        }
                            
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
                    AddContactView(persons: $viewModel.persons)
                }
                .onAppear {
                    print("I'm starting to populate ... \(viewModel.persons.count)")
                    viewModel.populatePersons()
                    print("did I run populate? \(viewModel.persons.count)")
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
