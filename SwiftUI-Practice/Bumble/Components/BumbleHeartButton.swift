//
//  BumbleHeartButton.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI

struct BumbleHeartButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 45, height: 45)
                .foregroundStyle(.bumbleYellow)
            
            Image(systemName: "bubble.fill")
                .font(.title)
                .foregroundStyle(.bumbleBlack)
                .offset(y: 2.5)

            
            Image(systemName: "heart.fill")
                .font(.system(size: 14))
                .foregroundStyle(Color.bumbleYellow)
        }
    }
}

#Preview {
    BumbleHeartButton()
}
