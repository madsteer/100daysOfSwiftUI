//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Cory Steers on 7/24/23.
//

import SwiftUI

struct FilteredListView: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedlastName)")
        }
    }
    
    init(filter: String) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}

struct FilteredListView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredListView(filter: "*")
    }
}
