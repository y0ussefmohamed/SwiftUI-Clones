//
//  SpotifyHomeView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 13/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    @Environment(\.router) var router
    
    @State private var products: [Product] = []
    @State private var currentUser: User = .mock
    @State private var selectedCategory: Category = .all
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                recentsSection
                
                Divider()
                    .padding(.top)
                
                newReleaseSection
                    .padding(.top)
                
                Divider()
                    .padding(.top)
                
                listRows
            }
            .scrollIndicators(.hidden)
            .clipped() // to the safe areas from top and bottom
            .ignoresSafeArea(edges: .bottom)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}

extension SpotifyHomeView {
    // MARK: - Views
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                ImageLoaderView(urlString: currentUser.image)
                    .background(.spotifyWhite)
                    .clipShape(Circle())
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(text: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.leading, 16)
        }
        .padding()
        .background(Color.spotifyBlack)
    }
    
    var recentsSection: some View {
        LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
            Section(header: header) {
                LazyVGrid(columns: columns) {
                    ForEach(products.suffix(8)) { product in
                        SpotifyRecentsCell(title: product.title, imageUrl: product.firstImage)
                            .asButton(.press) {
                                router.showScreen(.push) { _ in
                                    SpotifyPlaylistView(
                                        user: currentUser,
                                        product: product
                                    )
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var newReleaseSection: some View {
        Group {
            if let product = products.last {
                SpotifyNewReleaseCell(
                    imageUrl: product.firstImage,
                    brand: product.brand ?? product.title,
                    title: product.title,
                    category: product.category ?? "",
                    description: product.description,
                    onAddToPlaylist: {
                        print("Add to playlist")
                    },
                    onPlayPressed: {
                        print("Play")
                    }
                )
            }
        }
    }
    
    var listRows: some View {
        Group {
            SpotifyProductsRow(title: "Furniture", products: products.filter { $0.category == "furniture" })
            
            SpotifyProductsRow(title: "Beauty", products: products.filter { $0.category == "beauty" })

            SpotifyProductsRow(title: "Grocery", products: products.filter { $0.category == "groceries" })
        }
    }
    
    // MARK: - Functions
    @MainActor
    private func getData() async {
        guard products.isEmpty, currentUser == .mock else { return }
        
        do {
            self.currentUser = try await DatabaseHelper().getUsers()[9]
            self.products = try await DatabaseHelper().getProducts()
        } catch {
            print(error)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()
    }
}
