//
//  AddEditViewModel.swift
//  BookManager
//
//  Created by Wendell Richards on 12/18/25.
//

import SwiftUI
import SwiftData
internal import Combine

@MainActor
class AddEditViewModel: ObservableObject {
    
    private var bookToEdit: PersistentBook?
//    private let modelContext: ModelContext
    private let titleText: String
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var summary: String = ""
    
    @Published var review: String = ""
    @Published var status: ReadingStatus = .unknown
    @Published var rating: Int = 0
    @Published var genre: Genre = .unknown
    @Published var isFavorite: Bool = false
    @Published var cover: UIImage? = nil
    
    //computed Property
    var hasUnsavedChanges: Bool {
        return !title.isEmpty &&
        (title != bookToEdit?.title ?? ""
        || author != bookToEdit?.author ?? ""
        || summary != bookToEdit?.summary ?? ""
        || review != bookToEdit?.review ?? ""
        || status != bookToEdit?.status ?? .unknown
        || rating != bookToEdit?.rating ?? 0
        || genre != bookToEdit?.genre ?? .unknown)
    }
    
    init(book: PersistentBook? = nil){
        self.bookToEdit = book
//        self.modelContext = modelContext
        // This only happens if this is an edit
        if let book {
            self.titleText = "Edit Book"
            self.title = book.title
            self.author = book.author
            self.summary = book.summary
            
            self.review = book.review
            self.status = book.status
            self.rating = book.rating
            self.genre = book.genre
            self.isFavorite = book.isFavorite
            if let coverData = book.coverImage {
                self.cover = UIImage(data: coverData)
            }
        } else {
            self.titleText = "Add Book"
            self.title = ""
            self.author = ""
            self.summary = ""
            self.review = ""
            self.status = .unknown
            self.rating = 0
            self.genre = .unknown
            self.isFavorite = false
            self.cover = nil
            
        }
    }
    
    func save(modelContext: ModelContext){
        if !hasUnsavedChanges {
            return
        }
        let isNewBook = bookToEdit == nil
        let booktoSave = bookToEdit ?? PersistentBook(title:"")
        booktoSave.title = title
        booktoSave.author = author
        booktoSave.summary = summary
        booktoSave.review = review
        booktoSave.status = status
        booktoSave.rating = rating
        booktoSave.genre = genre
        booktoSave.isFavorite = isFavorite
        if cover != nil {
            booktoSave.coverImage =
            cover?.jpegData(compressionQuality: 1)
        }
        
        if isNewBook {
            modelContext.insert(booktoSave)
        }
        do {
            try modelContext.save()
        }catch{
            print("Failure saving book: \(error)")
        }
    }
    
    func getTitleText() -> String {
        return titleText
    }
}
