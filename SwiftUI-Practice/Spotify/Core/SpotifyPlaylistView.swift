//
//  SpotifyPlaylistView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 14/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    @Environment(\.router) var router
    
    var user: User = .mock
    var product: Product = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        title: product.title ,
                        subtitle: product.brand ?? "",
                        imageName: product.firstImage
                    )
                    .readingFrame { frame in /// this extension just reads how much a certain view x,y moves
                        showHeader = frame.maxY < 220
                    }
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category ?? product.brand ?? "",
                        onAddToPlaylistPressed: {},
                        onDownloadPressed: {},
                        onSharePressed: {},
                        onEllipsisPressed: {},
                        onShufflePressed: {},
                        onPlayPressed: {}
                    )
                    
                    ForEach(products.prefix(10)) { product in
                        SongRowCell(
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand ?? "",
                            onCellPressed: {
                                router.showScreen(.push) { _ in
                                    SpotifyPlaylistView(product: product)
                                }
                            },
                            onEllipsisPressed: {}
                        )
                    }
                    .padding(.leading)
                }
            }
            .scrollIndicators(.hidden)
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private var header: some View {
        ZStack { /// ZStack because the title will be centered by default and will make back btn to be on leading
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .offset(y: showHeader ? 0 : -50)
                .opacity(showHeader ? 1 : 0)
                .animation(.smooth(duration: 0.2), value: showHeader)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(
                    showHeader ? .spotifyGray.opacity(0) : .spotifyGray.opacity(0.7)
                )
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissLastScreen()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
        }
        .foregroundStyle(.spotifyWhite)
        .background(showHeader ? .spotifyBlack : .spotifyBlack.opacity(0))
        .animation(.smooth(duration: 0.2), value: showHeader)
    }
    
    @MainActor
    private func getData() async {
        do {
            self.products = try await DatabaseHelper().getProducts()
        } catch {
            print(error)
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
