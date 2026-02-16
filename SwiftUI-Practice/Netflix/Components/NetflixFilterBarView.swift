//
//  NetflixFilterBarView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI

struct NetflixFilterBarView: View {
    var filters: [FilterModel] = FilterModel.mockArray
    var selectedFilter: FilterModel? = nil
    var onFilterSelected: ((FilterModel) -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil
                        || selectedFilter == filter {
                        NetflixFilterCell(
                            isSelected: selectedFilter == filter,
                            isDropdown: filter.isDropdown,
                            categoryText: filter.title
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterSelected?(filter)
                        }
                        .padding(.leading, (selectedFilter == nil ? 16 : 0))
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.smooth, value: selectedFilter)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixFilterBarView()
    }
}
