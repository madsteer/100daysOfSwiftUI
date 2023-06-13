//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Cory Steers on 6/12/23.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    @State private var count = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                TextField("Description", text: $description)
                
                TextField("Count", value: $count, format: .number)
                    .keyboardType(.decimalPad)
            }
            .toolbar {
                Button("Save") {
                    activities.items.append(Activity(title: title, description: description, count: count))
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
