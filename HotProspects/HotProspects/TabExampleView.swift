//
//  TabExampleView.swift
//  HotProspects
//
//  Created by Dave Spina on 2/2/21.
//

import SwiftUI

class BookDetails: ObservableObject {
    @Published var bookName = ""
    @Published var author = ""
    @Published var rating: Int = 0
    @Published var review = ""
}

struct BookInfo: View {
    @EnvironmentObject var book: BookDetails
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Book Title", text: $book.bookName)
                TextField("Author", text: $book.author)
            }.navigationBarTitle(Text("Book Information"))
        }
    }
}

struct BookRating: View {
    @EnvironmentObject var book: BookDetails
    
    var body: some View {
        NavigationView {
            Form{
                Text("\(book.bookName)")
                    .font(.headline)
                Text("\(book.author)")
                    .font(.subheadline)
                Stepper("Rating", value: $book.rating, in: (0...4))
                Text("Rating: \(book.rating)")
                TextField("Review", text: $book.review)
            }.navigationBarTitle("Book Review")
        }
    }
}

struct TabExampleView: View {
    @State private var selectedTab = "Info"
    let book = BookDetails()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BookInfo()
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("Information")
                }
                .tag("Info")
            BookRating()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Review")
            }
            .tag("Review")
            
        }.environmentObject(book)
    }
}

struct TabExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TabExampleView()
    }
}
