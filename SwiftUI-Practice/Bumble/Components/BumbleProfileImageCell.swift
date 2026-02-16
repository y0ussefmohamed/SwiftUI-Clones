//
//  BumbleProfileImageCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var imageName: String = Constants.randomImageURL
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = Bool.random()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleBlack, lineWidth: 1)
                .overlay(
                    ImageLoaderView(urlString: imageName)
                        .clipShape(Circle())
                        .padding(4)
                )
                .frame(width: 70, height: 70)
                
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 3)
                .overlay(
                    Circle()
                        .stroke(.bumbleWhite, lineWidth: 6.5)
                        .frame(width: 16, height: 16)
                        .overlay(
                            Circle()
                                .fill(.bumbleYellow)
                                .frame(width: 16, height: 16)
                        )
                        .offset(x:-1, y: -2)
                        .opacity(hasNewMessage ? 1 : 0)
                    
                    , alignment: .bottomTrailing
                )
                .frame(width: 70, height: 70)
        }
    }
}

#Preview {
    BumbleProfileImageCell(percentageRemaining: 1)
    BumbleProfileImageCell(percentageRemaining: 0)
    BumbleProfileImageCell(percentageRemaining: 0.7, hasNewMessage: false)
    BumbleProfileImageCell(percentageRemaining: 0.3, hasNewMessage: true)
    BumbleProfileImageCell(percentageRemaining: 0, hasNewMessage: true)
}
