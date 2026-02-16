//
//  SpotifyNewReleaseCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 13/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyNewReleaseCell: View {
    @Environment(\.router) var router
    
    var imageUrl: String = Constants.randomImageURL
    var brand: String = "Apple"
    var title: String = "iPhone 14 Pro Max"
    var category: String = "smartphones"
    var description: String = "The latest in Apple's lineup of smartphones."
    var onAddToPlaylist: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ImageLoaderView(urlString: imageUrl)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(brand)
                        .font(.callout)
                        .foregroundStyle(.spotifyGray)
                    
                    Text(category)
                        .font(.title2)
                        .foregroundColor(.spotifyWhite)
                }
                .padding(.top, 5)
                
                Spacer()
            }
            
            HStack(alignment: .top, spacing: 16) {
                ImageLoaderView(urlString: imageUrl)
                    .frame(width: 140, height: 160)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.callout)
                        .foregroundStyle(.spotifyWhite)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    Text(description)
                        .font(.title3)
                        .foregroundStyle(.spotifyLightGray)
                        .lineLimit(2)
                        .padding(.trailing)
                        .padding(.top, 2)
                    
                    HStack(alignment: .bottom, spacing: 10) {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(Color(.systemGray4))
                            .font(.title3)
                            .padding(4)
                            .background(.blue.opacity(0.001)) // more tapable area
                            .onTapGesture {
                                onAddToPlaylist?()
                            }
                            .offset(x: -4, y: 4) // resets the padding 4 from leading and bottom
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(Color(.systemGray4))
                            .font(.title2)
                            .onTapGesture {
                                onPlayPressed?()
                            }
                    }
                    .padding(.trailing, 10)
                    .padding(.top, 30)
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.spotifyDarkGray)
            .cornerRadius(10)
            .asButton(.press) {
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        SpotifyNewReleaseCell()
    }
}
