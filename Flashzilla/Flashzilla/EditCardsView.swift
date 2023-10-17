//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Cory Steers on 10/11/23.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cards = [Card]()
    @State private var prompt = ""
    @State private var answer = ""
    
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Question", text: $prompt)
                    
                    TextField("Answer", text: $answer)
                    
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    func addCard() {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty  else { return }
        
        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        
        saveData()
        prompt = ""
        answer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        
        saveData()
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let savedCards = UserDefaults.standard.data(forKey: "Cards") {
            if let decodedCards = try? JSONDecoder().decode([Card].self, from: savedCards) {
                cards = decodedCards
                return
            }
        }
        
        cards = []
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: "Cards")
        }
    }
}

#Preview {
    NavigationView {
        EditCardsView()
    }
}
