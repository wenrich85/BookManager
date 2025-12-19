//
//  AddEditView.swift
//  BookManager
//
//  Created by Wendell Richards on 11/25/25.
//
import SwiftUI
import SwiftData

struct AddEditView: View {
    
    @StateObject private var viewModel: AddEditViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // This is ran only on creation
    init(book: PersistentBook? = nil){
       _viewModel = StateObject(
            wrappedValue:
                AddEditViewModel(book: book))
    }
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Book Cover")){
                    ImageField(image: $viewModel.cover)
                }
                
               // Section creates a "white glove around all input fields
                // Uses divide fields
                Section(header: Text("Book Details")){
                    // a plain text field
                    TextField("Title of the book", text: $viewModel.title)
                    TextField("Author", text: $viewModel.author)
                    Picker("Genre", selection: $viewModel.genre){
                        ForEach(Genre.allCases, id: \.self) {
                            genre in Text(genre.rawValue).tag(genre)
                        }
                    }
                    TextEditor(text: $viewModel.summary)
                        .frame(height: 150)
                }
                Section(header: Text("My Review")){
                    Picker("Rating", selection: $viewModel.rating){
                        Text("No Rating").tag(0 as Int)
                        ForEach(1...5, id: \.self){rating in
                            Text("\(rating)").tag(rating as Int)
                        }
                    }
                    Picker("Reading Status", selection: $viewModel.status){
                        //Enums hace a special property 'allCases'
                        ForEach(ReadingStatus.allCases, id: \.self){status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    TextEditor(text: $viewModel.review)
                        .frame(height: 150)
                }
            }.navigationBarTitle(viewModel.getTitleText())
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button("Save Book"){
                            viewModel.save(modelContext: modelContext)
                            
                            
                            dismiss()
                        }.disabled(!viewModel.hasUnsavedChanges)
        
                }
            }
            
        }
        
    }
}
