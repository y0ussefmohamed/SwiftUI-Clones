//
//  PlaylistHeaderCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 14/02/2026.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var title: String = "Huawei"
    var subtitle: String = "Huawei P30"
    var imageName: String = Constants.randomImageURL
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle().opacity(0) /// Better performance than putting the `ImageLoaderView` directly
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title3)
                    
                    Text(subtitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .foregroundColor(.spotifyWhite)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(colors: [shadowColor.opacity(0), shadowColor],
                                   startPoint: .top, endPoint: .bottom)
                )
                
                , alignment: .bottom
            )
            .asStretchyHeader(startingHeight: 300)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
