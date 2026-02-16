//
//  RateButton.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 16/02/2026.
//

import SwiftUI
import SwiftfulUI

enum RateOption: String, CaseIterable {
    case dislike, like, love
    
    var title: String {
        switch self {
        case .love:
            return "Love this!"
        case .like:
            return "I like this"
        case .dislike:
            return "Not for me"
        }
    }
    
    var iconName: String {
        switch self {
        case .love:
            return "bolt.heart"
        case .like:
            return "hand.thumbsup"
        case .dislike:
            return "hand.thumbsdown"
        }
    }
}

struct RateButton: View {
    @State private var showPopover: Bool = false
    var onRatingSelected: ((RateOption) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "hand.thumbsup")
                .font(.title)
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
                .asButton(.press) {
                    showPopover.toggle()
                }
                .popover(isPresented: $showPopover) {
                    ZStack {
                        Color.netflixDarkGray.ignoresSafeArea()
                        
                        HStack(spacing: 12) {
                            ForEach(RateOption.allCases, id: \.self) { option in
                                rateSubButton(option: option)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .presentationCompactAdaptation(.popover)
                }
            
            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        
    }
    
    private func rateSubButton(option: RateOption) -> some View {
            VStack(spacing: 8) {
                Image(systemName: option.iconName)
                    .font(.title2)
                Text(option.title)
                    .font(.caption)
            }
            .foregroundStyle(.netflixWhite)
            .padding(4)
            .background(Color.black.opacity(0.001))
            .onTapGesture {
                showPopover = false
                onRatingSelected?(option)
            }
        }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        RateButton()
    }
}
