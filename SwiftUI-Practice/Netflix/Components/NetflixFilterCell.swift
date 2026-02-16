//
//  NetflixFilterCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI

struct NetflixFilterCell: View {
    var isSelected: Bool = false
    var isDropdown: Bool = false
    var categoryText: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(categoryText)

            if isDropdown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                
                Capsule(style: .circular)
                    .fill(.netflixDarkGray)
                    .opacity(isSelected ? 1 : 0)
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
            }
        )
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack {
            NetflixFilterCell(isSelected: false, categoryText: "Action")
            
            NetflixFilterCell(isSelected: true,isDropdown: true,
                              categoryText: "Action")
            
            NetflixFilterCell(isSelected: false, categoryText: "Action")
            
            NetflixFilterCell(isSelected: true, isDropdown: true, categoryText: "Action")
        }
    }
    
}
