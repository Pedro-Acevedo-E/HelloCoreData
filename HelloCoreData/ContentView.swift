//
//  ContentView.swift
//  HelloCoreData
//
//  Created by Pedro Acevedo on 06/05/24.
//

import SwiftUI

struct ContentView: View {
    //All of this is a BAD idea, never put this in the view directly
    //Use a MVVM class instead or some other helper class
    let coreDM: CoreDataManager
    @State private var movieTitle: String = ""
    // NOT A GOOD IDEA TO USE STATE TO POPULATE DATA FROM
    // THIRD PARTY CALL
    @State private var movies: [Movie] = [Movie]()
    @State private var needsRefresh: Bool = false
    
    private func populateMovies() {
        movies = coreDM.getAllMovies()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $movieTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    //Remember DO NOT call the core data manager from inside the view, this is just for demonstration
                    coreDM.saveMovie(title: movieTitle)
                    populateMovies()
                }
                
                List {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(
                            destination: MovieDetail(movie: movie, coreDM: coreDM, needsRefresh: $needsRefresh),
                            label: {
                                Text(movie.title ?? "")
                            })
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            // delete it using Core Data Manager
                            coreDM.deleteMovie(movie: movie)
                            populateMovies()
                        }
                    })
                    
                }.listStyle(PlainListStyle())
                .accentColor(needsRefresh ? .white: .black)
                
                
                Spacer()
            }.padding()
            .navigationTitle("Movies")
            .onAppear(perform: {
                populateMovies()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
