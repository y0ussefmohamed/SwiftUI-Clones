//
//  PlaylistDescriptionCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 14/02/2026.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Product.mock.description
    var userName: String = "Youssef"
    var subheadline: String = "laptops"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .bottom,spacing: 8) {
                Image(systemName: "apple.logo")
                    .font(Font.system(size: 24))
                    .foregroundStyle(.spotifyGreen)
                
                HStack(spacing: 0) {
                    Text("Made for ")
                        .font(Font.system(size: 20))
                        .foregroundStyle(.spotifyLightGray)
                    
                    Text(userName)
                        .font(Font.system(size: 20))
                        .foregroundStyle(.spotifyLightGray)
                        .fontWeight(.bold)
                }
            }
            
            Text(subheadline)
                .font(.subheadline)
                .foregroundStyle(.spotifyLightGray)
            
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 0) {
                        Image(systemName: "plus.circle")
                            .padding(8)
                            .background(Color.spotifyBlack.opacity(0.001))
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                        
                        Image(systemName: "arrow.down.circle")
                            .padding(8)
                            .background(Color.spotifyBlack.opacity(0.001))
                            .onTapGesture {
                                onDownloadPressed?()
                            }
                        
                        Image(systemName: "square.and.arrow.up")
                            .padding(8)
                            .background(Color.spotifyBlack.opacity(0.001))
                            .onTapGesture {
                                onSharePressed?()
                            }
                    }
                    
                    
                    Image(systemName: "ellipsis")
                        .padding(8)
                        .background(Color.spotifyBlack.opacity(0.001))
                        .onTapGesture {
                            onEllipsisPressed?()
                        }
                }
                .offset(x: -8)
                
                HStack(spacing: 8) {
                    Image(systemName: "shuffle")
                        .font(.title)
                        .padding(8)
                        .background(Color.spotifyBlack.opacity(0.001))
                        .onTapGesture {
                            onShufflePressed?()
                        }
                    
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 40))
                        .padding(8)
                        .background(Color.spotifyBlack.opacity(0.001))
                        .onTapGesture {
                            onPlayPressed?()
                        }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundStyle(.spotifyGreen)
                
            }
            .font(.title2)
            .foregroundStyle(.spotifyLightGray)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        PlaylistDescriptionCell()
    }
}

