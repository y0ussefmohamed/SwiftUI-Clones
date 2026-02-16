//
//  ImageLoaderView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 24/12/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImageURL
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        
        Rectangle()
            .overlay(
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            )
            .clipped()
        
            
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
