//
//  PersistentBook.test.swift
//  BookManager
//
//  Created by Wendell Richards on 12/16/25.
//

import Testing // Swift Testing
@testable import BookManager

@MainActor @Suite("Persistent book tests")
struct PersistentBookTests {
    
    @Test("Persistent Book Initializer with default values")
    func testPersistentBookInitDefaultValues(){
        //Step 1: Arrange
        let bookTitle = "Test Book"
        
        //Step 2: Act
        let book = PersistentBook(title: bookTitle)
        //Step 3: Assert
        #expect(book.title == "Test Book")
        #expect(book.status == .unknown)
        #expect(book.author == "")
        #expect(book.summary == "")
        #expect(!book.isFavorite)
    }
    
    @Test("Persistent Book Initializer with Custom values")
    func testPersistentBookInitCustomValues(){
        //Step 1: Arrange
        let bookTitle = "Test Book"
        let status = ReadingStatus.reading
        let author = "Test Author"
        let favorite = true
        let summary = "This is a test summary for test book"
    
        //Step 2: Act
        let book = PersistentBook(title: bookTitle, author: author, summary: summary, status: status, isFavorite: favorite,)
        //Step 3: Assert
        #expect(book.title == "Test Book")
        #expect(book.status == .reading)
        #expect(book.author == "Test Author")
        #expect(book.summary == "This is a test summary for test book")
        #expect(book.isFavorite)
    }
   
    @Test("Test getNameAndAuthor function with author")
    func testGetNameAndAuthorWithAuthor() {
        //Arrange
        let bookTitle = "Test Book"
        let author = "Test Author"
        //Act
        let book = PersistentBook(title: bookTitle, author: author)
        let nameAndAuthor = book.getNameAndAuthor()
        //Assert
        
        #expect(nameAndAuthor == "\(bookTitle) by \(author)")
    }

    @Test("Test getNameAndAuthor function without author")
    func testGetNameAndAuthorWithoutAuthor() {
        //Arrange
        let bookTitle = "Test Book"
        //Act
        let book = PersistentBook(title: bookTitle)
        let nameAndAuthor = book.getNameAndAuthor()
        //Assert
        
        #expect(nameAndAuthor == "\(bookTitle)")
    }
}

