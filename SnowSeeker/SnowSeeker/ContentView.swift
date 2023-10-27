//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/24/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] =  Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var isShowingSortingSheet = false
    @State private var sort = SortType.defalt
    
    enum SortType {
        case defalt, name, country
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("this is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar {
                Button {
                    isShowingSortingSheet = true
                } label: {
                    Label("Change sort order", systemImage: "arrow.up.arrow.down.circle")
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .confirmationDialog("Select a sorting method", isPresented: $isShowingSortingSheet) {
                Button {
                    self.sort = .name
                } label: {
                    Text("Sort resorts by name")
                }
                
                Button {
                    self.sort = .country
                } label: {
                    Text("Sort resorts by country they are in")
                }
                
                Button {
                    self.sort = .defalt
                } label: {
                    Text("Do not sort the resorts at all")
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
//        .phoneOnlyNavigationView()
    }
    
    var filteredResorts: [Resort] {
        let sortedResorts = resorts.sorted { (lhs: Resort, rhs: Resort) in
            switch sort {
            case .name:
                lhs.name < rhs.name
            case .country:
                lhs.country < rhs.country
            default:
                true
            }
        }
                
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    ContentView()
}
