//
//  CategoryTextComponent.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 13/02/2026.
//

import SwiftUI
import Foundation

struct SpotifyCategoryCell: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        Text(text)
            .font(.callout)
            .frame(minWidth: 25) // for small text buttons to be bigger
            .padding(10)
            .padding(.horizontal, 5)
            .themeColors(isSelected: isSelected)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
    }
}
