//
//  BookLinkItem.swift
//  BookManager
//
//  Created by Wendell Richards on 11/22/25.
//
import SwiftUI

struct BookLinkItem: View {
    @Binding var book: Book
    
    var body: some View {
        HStack{
            Image(book.coverImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 60, maxHeight: 60)
            VStack(alignment: .leading ){
                Text(book.title)
                Text(book.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
