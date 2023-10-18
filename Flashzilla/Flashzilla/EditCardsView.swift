//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Cory Steers on 10/11/23.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var cards: [Card]
    @State private var prompt = ""
    @State private var answer = ""
    
    private let saveCardsFile = FileManager.documentsDirectory.appendingPathComponent("SavedCards")
    
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
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: saveCardsFile, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save the new card: \(error.localizedDescription)")
        }
    }
}

struct EditCardsView_Preview: PreviewProvider {
    static var previews: some View {
        @State var cards = [Card]()
        NavigationView {
            EditCardsView(cards: $cards)
        }
    }
}
