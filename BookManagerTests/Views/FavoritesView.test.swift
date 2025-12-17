//
//  FavoritesView.test.swift
//  BookManager
//
//  Created by Wendell Richards on 12/16/25.
//

import Testing
@testable import BookManager

@MainActor @Suite("FavoritesView tests")
struct FavoritesViewTests {
    @Test("Test flterFavoriteBook Function")
    func testfilterFavoriteBook() {
        //Arrange
        let books = [
            PersistentBook(title: "Book 1", isFavorite: true),
            PersistentBook(title: "Book 2"),
            PersistentBook(title: "Book 3")
        ]
        
        //Act
        let favoriteBooks = filterFavortieBook(books: books)
        
        //Assert
        #expect(favoriteBooks.count == 1)
        #expect(favoriteBooks.first?.title == "Book 1")
    }
    
    @Test("Test filterfavoritebook Function with genre and status")
    func testFileterFavoriteBookWithGenreAndStatus() {
        let books = [
            PersistentBook(title: "Book 1", status: .reading,  genre: .fantasy, isFavorite: true),
            PersistentBook(title: "Book 2", genre: .classic, isFavorite: true),
            PersistentBook(title: "Book 3")
        ]
        let seletedGenre: Genre? = .fantasy
        let selectedStatus: ReadingStatus? = .reading
        //Act
        let favoriteBooks = filterFavortieBook(books: books, selectedGenre: seletedGenre, selectedReadingStatus: selectedStatus)
        
        //Assert
        #expect(favoriteBooks.count == 1)
        #expect(favoriteBooks.first?.title == "Book 1")
    }
}
