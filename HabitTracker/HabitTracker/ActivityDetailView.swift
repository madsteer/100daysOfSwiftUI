//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Cory Steers on 6/12/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @State var activity: Activity
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Text("Description:")
                        .font(.headline)
                    
                    Text(activity.description)
                }
                
                HStack {
                    Text("Count:")
                        .font(.headline)
                    
                    Text(activity.count, format: .number)
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationTitle(activity.title)
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: Activity(
            title: "Sample",
            description: "Sample's description",
            count: 5)
        )
    }
}
