//
//  NetflixMovieCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 16/02/2026.
//

import SwiftUI
import SwiftfulUI

struct NetflixMovieCell: View {
    var imageWidth: CGFloat = 130
    var imageHeight: CGFloat = 160
    var imageName: String = Constants.randomImageURL
    var movieName: String? = "Movie Name"
    var isRecentlyAdded: Bool = false
    var topTenRank: Int? = 10
    var onPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .bottom) {
            if(topTenRank != nil) {
                Text(String(describing: topTenRank!))
                    .font(.system(size: 120, design: .serif))
                    .foregroundStyle(.netflixWhite)
                    .offset(x: 15, y: 25)
            }
            
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                    .frame(width: imageWidth, height: imageHeight)
                    .overlay(
                        LinearGradient(
                            colors: [
                                .netflixBlack.opacity(0),
                                .netflixBlack.opacity(0.3),
                                .netflixBlack.opacity(0.4),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(8)
                
                VStack {
                    if let movieName, let firstWord = movieName.components(separatedBy: " ").first {
                        Text(String(firstWord))
                            .font(.system(size: 20, design: .serif))
                            .foregroundColor(.netflixWhite)
                    }
                    
                    
                    Text("Recently Added")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .background(.netflixRed)
                        .cornerRadius(4)
                        .opacity(isRecentlyAdded ? 1 : 0)
                }
            }
        }
        .asButton(.press) {
            onPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        
        VStack {
            NetflixMovieCell()
            NetflixMovieCell(isRecentlyAdded: false, topTenRank: 7)
        }
        
    }
}
