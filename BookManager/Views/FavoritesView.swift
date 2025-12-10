//
//  FavoritesView.swift
//  BookManager
//
//  Created by Wendell Richards on 12/4/25.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var books: [Book]
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    //Computed Variable -> as soon as books binding variable changes the new variable will compute itself to match the state
    
    private var favoriteBooks: [Binding<Book>]{
        $books.filter {$0.wrappedValue.isFavorite}
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: gridLayout) {
                    ForEach(favoriteBooks, id: \.id) { book in
                        NavigationLink(destination: DetailView(book: book)){
                            BookCard(book: book)
                        }
                    }
                    
                }
            }.navigationBarTitle("My Favorite Books")
                .padding(20)
        }
    }
}
