//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Cory Steers on 6/12/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var activities: Activities
    @State var activity: Activity
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("", text: $activity.description)
                } header: {
                    Text("description")
                        .font(.headline)
                }
                
                Section {
                    HStack {
                        Button("+") {
                            self.activity.count += 1
                            updateElement()
                        }
                        
                        Divider()
                            .font(.headline)
                        
                        TextField("", value: $activity.count, format: .number)
                            .keyboardType(.decimalPad)
                    }
                } header: {
                    Text("count")
                        .font(.headline)
                }
            }
            .navigationTitle(activity.title)
            .toolbar {
                Button("Save") {
                    updateElement()
                    
                    dismiss()
                }
            }
        }
    }
    
    func updateElement() {
        let activityIndex = activities.items.findActivity(for: activity)
        if activityIndex >= 0 {
            if activity.id == activities.items[activityIndex].id {
                activities.items[activityIndex] = activity
            }
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(),
            activity: Activity(
            title: "Sample",
            description: "Sample's description",
            count: 5)
        )
        .preferredColorScheme(.dark)
    }
}
