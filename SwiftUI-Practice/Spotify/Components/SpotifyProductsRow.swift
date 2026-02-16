//
//  ProductsRow.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 13/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyProductsRow: View {
    @Environment(\.router) var router
    var title: String = "Apple"
    var products: [Product] = [Product.mock, Product.mock, Product.mock, Product.mock]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .foregroundStyle(.spotifyWhite)
                .font(.largeTitle)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(products) { product in
                        VStack {
                            rowCell(product: product)
                                .asButton(.press) {
                                    router.showScreen(.fullScreenCover) {_ in
                                        SpotifyPlaylistView(product: product)
                                    }
                                }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
    }
}

extension SpotifyProductsRow {
    private func rowCell(product: Product) -> some View {
        VStack {
            ImageLoaderView(urlString: product.firstImage)
                .frame(width: 130, height: 130)
            
            Text(product.title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 100)
                .foregroundStyle(.spotifyLightGray)
        }
        
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        SpotifyProductsRow()
    }
}
