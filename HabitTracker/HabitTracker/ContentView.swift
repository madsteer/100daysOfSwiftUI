//
//  ContentView.swift
//  HabitTracker
//
//  Created by Cory Steers on 6/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activities.items) { item in
                        Text(item.title)
                            .font(.headline)
                    }
                }
            }
            .padding()
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddActivityView(activities: activities)
            }
//            .onAppear { addAnActivity() }
        }
    }
    
//    func addAnActivity() {
//        var activity = Activity(title: "sample", description: "some random activity")
//        activities.items.append(activity)
//        activity = Activity(title: "s2", description: "another sample activity")
//        activities.items.append(activity)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
