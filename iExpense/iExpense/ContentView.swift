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
        for offset in offsets {
            if let index = expenses.items.firstIndex(
                where: { $0.id == personalExpenses[offset].id }
            ) {
                expenses.items.remove(at: index)
            }
        }
        buildLists()
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(
                where: { $0.id == businessExpenses[offset].id }
            ) {
                expenses.items.remove(at: index)
            }
        }
        buildLists()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
