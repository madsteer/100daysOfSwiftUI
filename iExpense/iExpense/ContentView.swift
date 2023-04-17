//
//  ContentView.swift
//  iExpense
//
//  Created by Cory Steers on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var personalExpenses = [ExpenseItem]()
    @State private var businessExpenses = [ExpenseItem]()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Personal")
                        .font(.largeTitle)
                    List {
                        ForEach(personalExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount,
                                     format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                                )
                                .foregroundColor((item.amount < 10) ? .black : (item.amount < 100) ? .blue : .red)
                            }
                        }
                        .onDelete(perform: removePersonalItems)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Business")
                        .font(.largeTitle)
                    List {
                        ForEach(businessExpenses) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount,
                                     format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                                )
                                .foregroundColor((item.amount < 10) ? .black : (item.amount < 100) ? .blue : .red)
                            }
                        }
                        .onDelete(perform: removeBusinessItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(
                    expenses: expenses,
                    buildLists: { self.buildLists() }
                )
            }
            .onAppear(perform: buildLists)
        }
    }
    
    func buildLists() {
        personalExpenses = expenses.items.expenseTypeFilter(desired: "Personal")
        businessExpenses = expenses.items.expenseTypeFilter(desired: "Business")
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        let items = offsets.map { self.personalExpenses[$0].id }
        removeItems(for: items)
        buildLists()
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        let items = offsets.map { self.businessExpenses[$0].id }
        removeItems(for: items)
        buildLists()
    }
    
    func removeItems(for uuids: [UUID]) {
        var indices = [Int]()
        
        uuids.forEach { uuid in
            for (index, element) in expenses.items.enumerated() {
                if element.id == uuid {
                    indices.append(index)
                }
            }
        }
        
        indices.forEach { index in
            expenses.items.remove(at: index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
