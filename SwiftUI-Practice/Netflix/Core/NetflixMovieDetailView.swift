//
//  NetflixMovieDetailView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 16/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixMovieDetailView: View {
    @Environment(\.router) var router
    
    var product: Product = .mock
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    @State private var progress: Double = 0.75
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.2).ignoresSafeArea()
            
            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    backgroundImageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {
                        
                    },
                    onXMarkPressed: {
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        detailsProductSection
                        buttonsSection
                        productsGridSection
                    }
                    .padding(8)
                    .padding(.top, 4)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
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


extension NetflixMovieDetailView {
    private var detailsProductSection: some View {
        NetflixDetailsProductView(
            title: product.title,
            isNew: true,
            yearReleased: "2024",
            seasonCount: 4,
            hasClosedCaptions: true,
            isTopTen: 6,
            descriptionText: product.description,
            castText: "Cast: Nick, Your Name, Someone Else",
            onPlayPressed: {
                
            },
            onDownloadPressed: {
                
            }
        )
    }
    
    private var buttonsSection: some View {
        HStack(alignment: .bottom, spacing: 32) {
                MyListButton(
                    isMyList: isMyList,
                    onButtonPressed: {
                        isMyList.toggle()
                    }
                )
                
                RateButton { optionSelected in
                    print("Selected: \(optionSelected.title)")
                }
                .offset(y: -8)
                
                ShareButton()
            }
            .padding(.leading, 32)
    }
    
    private var productsGridSection: some View {
        VStack (alignment: .leading){
            Text("More Like This")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top, 32)
                .foregroundStyle(.netflixWhite)
            
            NonLazyVGrid(
                columns: 3,
                alignment: .leading,
                spacing: 10,
                items: products,
                content: { product in
                    if let product {
                        NetflixMovieCell(
                            imageWidth: 120,
                            imageHeight: 150,
                            imageName: product.firstImage,
                            movieName: product.title,
                            isRecentlyAdded: false,
                            topTenRank: nil,
                            onPressed: {
                                router.showScreen(.sheet) { _ in
                                    NetflixMovieDetailView(product: product)
                                }
                            }
                        )
                    }
                }
            )
        }
        
    }
}

#Preview {
    NetflixMovieDetailView()
}
