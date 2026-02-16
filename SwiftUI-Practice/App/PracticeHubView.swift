//
//  PracticeHubView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 14/02/2026.
//

import SwiftUI
import SwiftfulRouting

struct PracticeHubView: View {
    @Environment(\.router) var router
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    
                    // MARK: - Spotify
                    ProjectCard(
                        title: "Spotify Clone",
                        subtitle: "Simple UI",
                        icon: "music.note",
                        gradientColors: [.green, .green.opacity(0.7)]
                    ) {
                        router.showScreen(.push) { _ in
                            SpotifyHomeView()
                        }
                    }
                    
                    // MARK: - Bumble
                    ProjectCard(
                        title: "Bumble Clone",
                        subtitle: "Swipe Gestures",
                        icon: "hexagon.fill",
                        gradientColors: [.yellow, .orange]
                    ) {
                        router.showScreen(.push) { _ in
                            BumbleHomeView()
                        }
                    }
                    
                    // MARK: - Netflix
                    ProjectCard(
                        title: "Netflix Clone",
                        subtitle: "Micro Animations",
                        icon: "play.tv.fill",
                        gradientColors: [Color(red: 0.8, green: 0, blue: 0), .red]
                    ) {
                        router.showScreen(.push) { _ in
                            NetflixHomeView()
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("SwiftUI Clones")
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct ProjectCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let gradientColors: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(
                LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(16)
            .shadow(color: gradientColors.first?.opacity(0.3) ?? .clear, radius: 8, x: 0, y: 4)
        }
        .buttonStyle(ScaleButtonStyle()) // Adds a nice press animation
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    RouterView { _ in
        PracticeHubView()
    }
}
