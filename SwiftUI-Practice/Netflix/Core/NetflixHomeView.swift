//
//  NetflixHomeView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    @Environment(\.router) var router
    
    @State private var products: [Product] = []
    @State private var currentUser: User = .mock
    @State private var heroProduct: Product? = nil
    
    private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollYAxisValue: CGFloat = 800
    
    var body: some View {
        ZStack(alignment: .top) {
            backgroundColor
            
            ScrollView(.vertical) {
                Rectangle() /// for the scroll view to appear normally as if there is no header above it
                    .frame(height: fullHeaderSize.height) /// same header hight to mock it behind
                    .opacity(0)
                
                NetflixFilterBarView(
                    selectedFilter: selectedFilter,
                    onFilterSelected: { newFilter in
                        selectedFilter =
                        (newFilter == selectedFilter) ? nil : newFilter
                    },
                    onXMarkPressed: {
                        selectedFilter = nil
                    })
                .offset(y: scrollYAxisValue > 640 ? 0 : -200)
                .animation(
                        scrollYAxisValue > 640 ? nil : .easeInOut(duration: 0.8),
                        value: scrollYAxisValue > 640
                    )
                
                ZStack {
                    Rectangle()
                        .aspectRatio(0.8, contentMode: .fit)
                        .opacity(0)
                    
                    if let heroProduct {
                        NetflixHeroCell(
                            imageName: heroProduct.firstImage,
                            isNetflixFilm: false,
                            title: "\(Int(scrollYAxisValue))",
                            onBackgroundPressed: {
                                router.showScreen(.sheet) { _ in
                                    NetflixMovieDetailView(product: heroProduct)
                                }
                            },
                            onPlayPressed: {},
                            onMyListPressed: {}
                        )
                        .padding(20)
                        .readingFrame { frame in
                            scrollYAxisValue = frame.maxY
                        }
                        
                    }
                }
                
                
                scrollableFilmCategories
            }
            .scrollIndicators(.hidden)
            
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
            }
            .background(.ultraThinMaterial.opacity(scrollYAxisValue < 630 ? 1 : 0))
            .brightness(-0.2)
            .animation(.smooth(duration: 0.25), value: scrollYAxisValue)
            .readingFrame { frame in
                fullHeaderSize = frame.size
            }
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @MainActor
    private func getData() async {
        //guard products.isEmpty, currentUser == .mock else { return }
        
        do {
            self.currentUser = try await DatabaseHelper().getUsers()[9]
            self.products = try await DatabaseHelper().getProducts()
            heroProduct = products.last
        } catch {
            print(error)
        }
    }
}


extension NetflixHomeView {
    private var backgroundColor: some View {
        ZStack {
            Color.bumbleBlack
                .ignoresSafeArea()
            
            LinearGradient(
                colors: [
                    .netflixDarkRed,
                    .netflixBlack,
                    .netflixBlack
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .opacity(scrollYAxisValue > 640 ? 1 : 0)
        }
        .animation(.smooth(duration: 1), value: scrollYAxisValue > 640)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For Youssef")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
        .foregroundStyle(scrollYAxisValue < 600 ? .netflixBlack : .netflixWhite)
    }
    
    private var scrollableFilmCategories: some View {
        LazyVStack {
            VStack(alignment: .leading) {
                Text("Top 10")
                    .font(.largeTitle)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(products.prefix(10).enumerated()), id: \.offset) { (index, product) in
                            NetflixMovieCell(
                                imageName: product.firstImage,
                                movieName: product.title,
                                isRecentlyAdded: index % 3 == 0,
                                topTenRank: index+1,
                                onPressed: {
                                    router.showScreen(.sheet) { _ in
                                        NetflixMovieDetailView(product: product)
                                    }
                                }
                            )
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text("Trending")
                    .font(.largeTitle)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(products.prefix(10).enumerated()), id: \.offset) { (index, product) in
                            NetflixMovieCell(
                                imageName: product.firstImage,
                                movieName: product.title,
                                isRecentlyAdded: index % 3 == 0,
                                topTenRank: nil,
                                onPressed: {
                                    router.showScreen(.sheet) { _ in
                                        NetflixMovieDetailView(product: product)
                                    }
                                }
                            )
                        }
                    }
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading) {
                Text("Now in Cinema")
                    .font(.largeTitle)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(products.suffix(10).enumerated()), id: \.offset) { (index, product) in
                            NetflixMovieCell(
                                imageName: product.firstImage,
                                movieName: product.title,
                                isRecentlyAdded: index % 3 == 0,
                                topTenRank: nil,
                                onPressed: {
                                    router.showScreen(.sheet) { _ in
                                        NetflixMovieDetailView(product: product)
                                    }
                                }
                            )
                        }
                    }
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading) {
                Text("Worst 10")
                    .font(.largeTitle)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(products.suffix(10).enumerated()), id: \.offset) { (index, product) in
                            NetflixMovieCell(
                                imageName: product.firstImage,
                                movieName: product.title,
                                isRecentlyAdded: index % 3 == 0,
                                topTenRank: 10-index,
                                onPressed: {
                                    router.showScreen(.sheet) { _ in
                                        NetflixMovieDetailView(product: product)
                                    }
                                }
                            )
                            
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    RouterView { _ in
        NetflixHomeView()
    }
}
