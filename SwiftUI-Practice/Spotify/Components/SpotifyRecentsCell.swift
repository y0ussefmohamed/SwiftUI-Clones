//
//  SpotifyRecentsCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 13/02/2026.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    var title: String = "Title"
    var imageUrl: String = Constants.randomImageURL
    
    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageUrl)
                .frame(width: 60, height: 70)
            
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyWhite)
                .fontWeight(.semibold)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.spotifyDarkGray)
        .cornerRadius(10)

    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        SpotifyRecentsCell()
    }
}
