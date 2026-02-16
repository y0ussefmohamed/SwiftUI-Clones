//
//  BumbleCardView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    var user: User = .mock
    var onSendAComplimentPressed: (() -> Void)? = nil
    var onSuperLikePressed: (() -> Void)? = nil
    var onXmarkPressed: (() -> Void)? = nil
    var onCheckmarkPressed: (() -> Void)? = nil
    var onHideAndReportPressed: (() -> Void)? = nil
    
    @State private var fullFrame: CGRect = .zero
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                headerCell
                    .frame(height: fullFrame.height)
                
                aboutMeSection
                    .padding(24)
                
                myInterestsSection
                    .padding(24)
                
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: fullFrame.height)
                }
                
                locationSection
                    .padding(24)
                
                footerSection
                    .padding(60)
                    .padding(.horizontal, 32)
            }
            
        }
        .background(.bumbleBackgroundYellow)
        .cornerRadius(40)
        .padding()
        .overlay(
            superLikeButton
            ,alignment: .bottomTrailing
        )
        .scrollIndicators(.hidden)
        .readingFrame { frame in
            fullFrame = frame /// to make the card height correct for each phone
        }
    }
}


extension BumbleCardView {
    private var headerCell: some View {
        ZStack {
            ImageLoaderView(urlString: user.image)
                .cornerRadius(40)
                .overlay(
                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.firstName)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        
                        HStack {
                            Image(systemName: "figure.walk.suitcase.rolling")
                            
                            Text(user.work)
                        }
                        
                        HStack {
                            Image(systemName: "graduationcap")
                            
                            Text(user.education)
                        }
                        
                        BumbleHeartButton()
                            .onTapGesture {
                                onSendAComplimentPressed?()
                            }
                    }
                        .padding(.horizontal)
                        .padding(.vertical, 48)
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color.bumbleBlack.opacity(0.001) ,
                                    .bumbleBlack.opacity(0.6),
                                    .bumbleBlack.opacity(0.6)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(40)
                        .foregroundStyle(.bumbleWhite)
                    
                    ,
                    alignment: .bottomLeading
                )
        }
        
    }
    
    private func sectionTitle(title: String)  -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
    
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0) {
                BumbleHeartButton()
                
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .onTapGesture {
                onSendAComplimentPressed?()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My basics")
                InterestPillGridView(interests: user.basics)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My interests")
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇺🇸", text: "Lives in New York, NY")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var footerSection: some View {
        VStack(spacing: 24) {
            HStack(spacing: 0) {
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onXmarkPressed?()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onCheckmarkPressed?()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onHideAndReportPressed?()
                }
        }
    }
    
    private var superLikeButton: some View {
        ZStack {
            Image(systemName: "hexagon.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 60))
            
            Image(systemName: "star.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 30))
        }
            .padding(30)
            .onTapGesture {
                onSuperLikePressed?()
            }
    }
}

#Preview {
    BumbleCardView()
}

