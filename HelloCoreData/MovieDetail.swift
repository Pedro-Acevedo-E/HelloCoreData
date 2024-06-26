//
//  MovieDetail.swift
//  HelloCoreData
//
//  Created by Pedro Acevedo on 06/05/24.
//

import SwiftUI

struct MovieDetail: View {
    
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManager
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        let movie = Movie()
        let coreDM = CoreDataManager()
        
        MovieDetail(movie: movie, coreDM: coreDM, needsRefresh: .constant(false))
    }
}
