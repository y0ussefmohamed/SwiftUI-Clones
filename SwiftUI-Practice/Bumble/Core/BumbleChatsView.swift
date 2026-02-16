//
//  BumbleChatsView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI
import SwiftfulRouting
struct BumbleChatsView: View {
    var users: [User] = []
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            header
            
            matchQueue
            
            ScrollView(.vertical) {
                recentChats
                
                ForEach(users) { user in
                    BumbleChatPreviewCell(imageName: user.image)
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension BumbleChatsView {
    private var header: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    router.dismissScreen()
                }
            
            Spacer(minLength: 0)
            
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .padding()
    }
    
    private var matchQueue: some View {
        VStack {
            HStack {
                Text("Match Queue")
                Text("(30)")
                    .foregroundStyle(.bumbleGray)
                
                Spacer()
            }
            .font(.title3)
            .padding([.horizontal, .top])
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(users) { user in
                        let _percentageRemaining = Double.random(in: 0...1)
                        let _hasNewMessage = Bool.random()
                        BumbleProfileImageCell(imageName: user.image, percentageRemaining: _percentageRemaining, hasNewMessage: _hasNewMessage)
                    }
                }
                .padding([.leading, .vertical])
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private var recentChats: some View {
        HStack {
            Text("Chats")
            Text("(Recent)")
                .foregroundStyle(.bumbleGray)
            
            Spacer()
            
            Image(systemName: "line.3.horizontal.decrease")
        }
        .font(.title3)
        .padding()
    }
}

#Preview {
    BumbleChatsView()
}
