//
//  AddEditView.swift
//  BookManager
//
//  Created by Wendell Richards on 11/25/25.
//
import SwiftUI

struct AddEditView: View {
    
    @Binding var bookToEdit: Book
    @State var workingBook: Book
    @Environment(\.dismiss) var dismiss
    
    private var titleText: String
    // This is ran only on creation
    init(bookToEdit: Binding<Book>){
        self._bookToEdit = bookToEdit
        self._workingBook = .init(initialValue: bookToEdit.wrappedValue)
        self.titleText = bookToEdit.wrappedValue.title.isEmpty ? "Add Book" : "Edit Book"
    }
    var body: some View {
        NavigationStack{
            Form{
               // Section creates a "white glove around all input fields
                // Uses divide fields
                Section(header: Text("Book Details")){
                    // a plain text field
                    TextField("Title of the book", text: $workingBook.title)
                    TextField("Author", text: $workingBook.author)
                    Picker("Genre", selection: $workingBook.genre){
                        ForEach(Genre.allCases, id: \.self) {
                            genre in Text(genre.rawValue).tag(genre)
                        }
                    }
                    TextEditor(text: $workingBook.details)
                        .frame(height: 150)
                }
                Section(header: Text("My Review")){
                    Picker("Rating", selection: $workingBook.rating){
                        Text("No Rating").tag(0 as Int)
                        ForEach(1...5, id: \.self){rating in
                            Text("\(rating)").tag(rating as Int)
                        }
                    }
                    Picker("Reading Status", selection: $workingBook.status){
                        //Enums hace a special property 'allCases'
                        ForEach(ReadingStatus.allCases, id: \.self){status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    TextEditor(text: $workingBook.review)
                        .frame(height: 150)
                }
            }.navigationBarTitle(titleText)
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save Book"){
                            dismiss()
                            self.$bookToEdit.wrappedValue = self.workingBook
                        }.disabled(workingBook.title.isEmpty)
        
                }
            }
            
        }
        
    }
}
