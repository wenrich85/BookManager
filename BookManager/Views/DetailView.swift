//
//  DetailView.swift
//  BookManager
//
//  Created by Wendell Richards on 11/22/25.
//
import SwiftUI

struct DetailView: View{
    
    @Binding var book: Book
    @State var showEditBookSheet: Bool = false
    
    
    var body: some View {
        ScrollView(){
            VStack(alignment: .leading, spacing: 20){
                HStack {
                    Image(book.coverImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100, maxHeight: 150)
                        .padding(.vertical, 20)
                    VStack(alignment: .leading){
                        Text(book.title)
                            .font(.title2)
                        Text("by: \(book.author == "" ? "Unknown" : book.author)")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    
                }
            }
                VStack(alignment: .leading, spacing: 15){
                    
                    
                    HStack {
                        if (book.status != .unknown){
                            CustomCapsule(text: book.status.rawValue, color: .green)
                        }
                        if (book.genre != .unknown){
                            CustomCapsule(text: book.genre.rawValue, color: .green)
                        }
                        Spacer()
                        FavoritesToggle(isFavorite: $book.isFavorite)
                    }
                        Text(book.details)
                        if (book.rating == 0) {
                            Text("No review yet.")
                        }else{
                            Text("Rating: \(book.rating)\(book.rating == 1 ? " star" : " stars")")
                            Text("\(String(repeating: "⭐️", count: Int(book.rating)))")
                        
                        Text(book.review)
                    }
                }.padding(.horizontal, 20)
        }
        .navigationBarItems(trailing: Button("Edit"){
            showEditBookSheet.toggle()
        })
        .sheet(isPresented: $showEditBookSheet){
            AddEditView(bookToEdit: $book)
        }
    }
}
