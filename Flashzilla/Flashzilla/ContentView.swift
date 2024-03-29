//
//  ContentView.swift
//  Flashzilla
//
//  Created by Cory Steers on 9/28/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var cards = [Card]()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let saveCardsFile = FileManager.documentsDirectory.appendingPathComponent("SavedCards")
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActiveApp = true
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cards, id: \.id) { card in
                        if let index = cards.firstIndex(of: card) {
                            CardView(card: card) { correct in
                                withAnimation(Animation.linear.delay(0.6)) {
                                    removeCard(at: index, isCorrect: correct)
                                }
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        }
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isCorrect: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isCorrect: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActiveApp else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActiveApp = true
                }
            } else {
                isActiveApp = false
            }
        }
//        .onChange(of: scenePhase) { newPhase in                // !!! deprecated in iOS17
//            isActiveApp = (newPhase == .active) ? true : false
//        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCardsView(cards: $cards)
        }
        .onAppear(perform: resetCards)
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: saveCardsFile)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print(error.localizedDescription)
            cards = []
        }
    }

    func resetCards() {
        loadData()
        timeRemaining = 100
        isActiveApp = true
    }
    
    func removeCard(at index: Int, isCorrect: Bool) {
        guard index >= 0 else { return }
        let removedCard = cards[index]
        cards.remove(at: index)
        
        if !isCorrect {
            let newCard = Card(id: UUID(), prompt: removedCard.prompt, answer: removedCard.answer)
            cards.insert(newCard, at: 0)
        }
        
        if cards.isEmpty {
            isActiveApp = false
        }
    }
}

#Preview {
    ContentView()
}
