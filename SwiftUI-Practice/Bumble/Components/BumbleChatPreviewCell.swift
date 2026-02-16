//
//  BumbleChatPreviewCell.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//



import SwiftUI

struct BumbleChatPreviewCell: View {
    var imageName: String = Constants.randomImageURL
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = Bool.random()
    var userName: String = "Youssef"
    var lastChatMessage: String? = "This is the last message sent to you."
    var isYourMove: Bool = Bool.random()
    
    var body: some View {
        VStack {
            HStack {
                BumbleProfileImageCell(imageName: imageName, percentageRemaining: percentageRemaining, hasNewMessage: hasNewMessage)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 0) {
                        Text(userName)
                            .font(.headline)
                            .foregroundStyle(.bumbleBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if isYourMove {
                            Text("YOUR MOVE")
                                .font(.caption2)
                                .bold()
                                .padding(.vertical, 4)
                                .padding(.horizontal, 6)
                                .background(.bumbleYellow)
                                .cornerRadius(32)
                        }
                    }
                    
                    if let lastChatMessage {
                        Text(lastChatMessage)
                            .font(.subheadline)
                            .foregroundStyle(.bumbleGray)
                            .padding(.trailing, 16)
                    }
                }
                .lineLimit(1)
            }
            
        }
    }
}

extension BumbleChatPreviewCell {
    
}

#Preview {
    BumbleChatPreviewCell()
        .padding()
}
