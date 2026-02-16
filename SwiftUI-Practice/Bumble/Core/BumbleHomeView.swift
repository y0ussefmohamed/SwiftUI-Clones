//
//  BumbleHomeView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 14/02/2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View
{
    @Environment(\.router) var router
    
    var filters = ["Everyone", "Trending"]
    @State var selectedFilter: String = "Everyone"
    @State private var allUsers: [User] = []
    @State var selectedIndex: Int = 1
    @State var cardOffsets: [Int: Bool] = [:] /// UserId : (Direction is Right == TRUE)
    @State var currentSwipeOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 8) {
                header
                
                BumbleFilterView(options: filters, selectedOption: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            let isPrevious = (selectedIndex-1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex+1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                /// computed and the user likes or dislikes already
                                let offsetValue = cardOffsets[user.id]
                                
                                userProfileCell(index: index)
                                    /// just for the isCurrent to show, not the isNext
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    }
                    else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndicators
                    .zIndex(999999)
                }
                .frame(maxHeight: .infinity)
                .animation(.smooth, value: cardOffsets)
            }
            .toolbar(.hidden, for: .navigationBar)
            .padding(8)
        }
        .task {
            await getData()
        }
    }
    
    
    @MainActor
    private func getData() async {
        guard allUsers.isEmpty else { return }
        
        do {
            self.allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print(error)
        }
    }
}

extension BumbleHomeView {
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .bold()
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .bold()
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        BumbleChatsView(users: allUsers)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    private func userProfileCell(index: Int) -> some View {
        BumbleCardView(user: allUsers[index])
            .withDragGesture(
                .horizontal,
                minimumDistance: 10,
                resets: true,
                rotationMultiplier: 1.3,
                onChanged: { dragOffset in
                    currentSwipeOffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -100 { // swiped left
                        userDidSelect(index: index, didLike: false)
                    }
                    else if dragOffset.width > 100 { // swiped right
                        userDidSelect(index: index, didLike: true)
                    }
                })
    }
    
    private var overlaySwipingIndicators: some View {
        ZStack {
            swipeButton(iconName: "xmark")
                /// swiping functionality
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)

            swipeButton(iconName: "checkmark")
                /// swiping functionality
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
    
    private func swipeButton(iconName: String) -> some View {
        Circle()
            .fill(.bumbleGray.opacity(0.4))
            .overlay(
                Image(systemName: iconName)
                    .font(.title)
                    .fontWeight(.semibold)
            )
            .frame(width: 60, height: 60)
    }
    
    private func userDidSelect(index: Int, didLike: Bool) {
        let user = allUsers[index]
        
        cardOffsets[user.id] = didLike /// if liked or disliked don't show again
        selectedIndex += 1
    }
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}
