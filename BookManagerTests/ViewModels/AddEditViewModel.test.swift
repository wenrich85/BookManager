//
//  AddEditViewModel.test.swift
//  BookManager
//
//  Created by Wendell Richards on 12/18/25.
//

import Testing
import SwiftData
@testable import BookManager


@MainActor
struct AddEditViewModelTests {
    @Test("Initalize ViewModel with no book")
    func initializeWithNoBook() throws {

//        Act
        let viewModel = AddEditViewModel()
//        Assert
        //Check the Navigation Title
        #expect(viewModel.getTitleText() == "Add Book")
        
        //Check the fields
        #expect(viewModel.title == "")
        #expect(viewModel.author == "")
        #expect(viewModel.genre == .unknown)
        #expect(viewModel.isFavorite == false)
        #expect(viewModel.summary == "")
        #expect(viewModel.status == .unknown)
        #expect(viewModel.hasUnsavedChanges == false)
        #expect(viewModel.rating == 0)
    }
    
    @Test("Initialize ViewModel with an existing book")
    func initializeWithBook() throws {
        //        Arrange
        let book = PersistentBook(
            title: "Test Book",
            author: "Author Name",
            summary: "A short summary of the book",
            status: .planToRead,
            rating: 5,
            genre: .fantasy,
            isFavorite: true,
        )
        
        // Act
        let viewModel = AddEditViewModel(book: book)
        #expect(viewModel.getTitleText() == "Edit Book")
        
        #expect(viewModel.title == book.title)
        #expect(viewModel.author == book.author)
        #expect(viewModel.genre == book.genre)
        #expect(viewModel.isFavorite == book.isFavorite)
        #expect(viewModel.summary == book.summary)
        #expect(viewModel.status == book.status)
        
        #expect(viewModel.hasUnsavedChanges == false)
    }
    
  //Can be saved works correctly
    @Test("Can Save Book")
    func canBeSavedNewBook() throws {

        //Act I
        let viewModel = AddEditViewModel()
//        Assert I
        #expect(!viewModel.hasUnsavedChanges)
//        Act II
        viewModel.title = "Test Book"
        viewModel.author = "Author Name"
        //Assert II
        #expect(viewModel.hasUnsavedChanges)
//        Act III
        viewModel.title = ""
//        Assert III
        #expect(!viewModel.hasUnsavedChanges)
    }
    
    //Can be saved works correctly
      @Test("Can Save Existing Book")
      func canBeSavedExistingBook() throws {
          //Arrange
          let book = PersistentBook(
              title: "Test Book",
              author: "Author Name",
              summary: "A short summary of the book",
              status: .planToRead,
              rating: 5,
              genre: .fantasy,
              isFavorite: true,
          )
          //Act I
          let viewModel = AddEditViewModel(book: book)
  //        Assert I
          #expect(!viewModel.hasUnsavedChanges)
  //        Act II
          viewModel.title = "Test Book"
          viewModel.author = "Author Name2"
          //Assert II
          #expect(viewModel.hasUnsavedChanges)
  //        Act III
          viewModel.title = ""
  //        Assert III
          #expect(!viewModel.hasUnsavedChanges)
      }
    
    
}
