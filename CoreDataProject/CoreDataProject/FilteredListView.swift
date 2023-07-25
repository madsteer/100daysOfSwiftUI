//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Cory Steers on 7/24/23.
//

import CoreData
import SwiftUI

enum PredicateVerb: String {
    case beginsWith = "BEGINSWITH"
}

struct FilteredListView<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    // this is our content closure;  we'll call this once for each item in the liast
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, filterVerb: PredicateVerb, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "\(filterKey) \(filterVerb.rawValue) %@", filterValue))
        self.content = content
    }
}
