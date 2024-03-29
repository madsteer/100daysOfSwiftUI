//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Cory Steers on 7/18/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    let lastNameSort = SortDescriptor<Singer>(\.lastName)
    let descendingFirstNameSOrt = SortDescriptor<Singer>(\.firstName, order: .reverse)
    
    var body: some View {
        VStack {
            FilteredListView(filterKey: "lastName", filterValue: lastNameFilter, filterVerb: .beginsWith, sortDescriptors: [lastNameSort, descendingFirstNameSOrt]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
