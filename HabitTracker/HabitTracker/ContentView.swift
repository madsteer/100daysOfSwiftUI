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
        NavigationStack {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        ActivityDetailView(activities: activities, activity: item)
                    } label: {
                        Text(item.title)
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .background(.lightBackground)
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
    
    func removeActivity(at offsets: IndexSet) {
        for offset in offsets {
            if let index = activities.items.firstIndex(
                where: { $0.id == activities.items[offset].id }
            ) {
                activities.items.remove(at: index)
            }
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
            .preferredColorScheme(.dark)
    }
}
