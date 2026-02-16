//
//  SwiftUI_PracticeApp.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 24/12/2025.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUI_PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                PracticeHubView()
            }
        }
    }
}
