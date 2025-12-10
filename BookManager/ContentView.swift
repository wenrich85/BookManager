//
//  ContentView.swift
//  BookManager
//
//  Created by Wendell Richards on 11/22/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var books = getBooks()
    
    var body: some View {
        
       TabView {
           BookListView(books: $books)
               .tabItem {
                   Label("Books", systemImage: "books.vertical.fill")
               }
           FavoritesView(books: $books)
               .tabItem {
                   Label("Favorites", systemImage: "heart.fill")
               }
               
        }
       .tabViewStyle(.tabBarOnly)
    }
}

#Preview {
    ContentView()
}
