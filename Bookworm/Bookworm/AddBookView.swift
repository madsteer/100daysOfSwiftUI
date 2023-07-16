//
//  AddBookView.swift
//  Bookworm
//
//  Created by Cory Steers on 7/11/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @State private var isValidGenre = false
    
    var isValidTitle: Bool {
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isValidAuthor: Bool {
        return !author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Educational"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: genre, perform: { _ in
                        onGenreChange()
                    })
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                }
                .disabled(!hasValidEntry())
            }
        }
        .navigationTitle("Add Book")
    }
    
    func hasValidEntry() -> Bool {
        return isValidTitle && isValidAuthor && isValidGenre
    }
    
    func onGenreChange() {
        isValidGenre = true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBookView()
        }
    }
}
