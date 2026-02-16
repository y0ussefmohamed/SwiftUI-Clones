# 📱 SwiftUI Clones

A collection of pixel-perfect UI clones of popular apps built entirely with **SwiftUI**. This project demonstrates modern iOS UI development techniques including custom animations, gesture handling, and component-based architecture.

## Clones Included

### 🎵 Spotify Clone

A recreation of the Spotify interface featuring:

- Home feed with recently played, new releases, and categorized playlists
- Playlist detail view with song rows and descriptions
- Custom category cells and product rows
- Smooth navigation transitions

### 🐝 Bumble Clone

A swipe-card dating app interface featuring:

- Interactive swipe gesture cards with snap-back animations
- Profile cards with image galleries and interest pills
- Filter bar for browsing preferences
- Chat preview list with profile image cells
- Heart button interactions

### 🎬 Netflix Clone

A streaming platform interface featuring:

- Hero banner with animated call-to-action buttons
- Horizontally scrolling movie rows with category filters
- Movie detail view with custom header and product info
- My List, Rate, and Share button components
- Micro-animations for enhanced user experience

## 🏗️ Architecture

The project follows a clean, modular architecture:

```
SwiftUI-Practice/
├── App/
│   ├── PracticeHubView.swift      # Main hub with navigation to all clones
│   ├── SwiftUI_PracticeApp.swift   # App entry point
│   └── Shared/                     # Shared models & utilities
│       ├── Product.swift
│       ├── User.swift
│       ├── DatabaseHelper.swift
│       ├── ImageLoaderView.swift
│       └── Constants.swift
├── Spotify/
│   ├── Core/                       # Main views
│   ├── Components/                 # Reusable UI components
│   └── Models/
├── Bumble/
│   ├── Core/
│   ├── Components/
│   └── Models/
└── Netflix/
    ├── Core/
    ├── Components/
    └── Models/
```

## 🛠️ Tech Stack

- **SwiftUI** — Declarative UI framework
- **SwiftfulRouting** — Navigation and routing
- **SwiftfulUI** — UI utilities and extensions
- **Xcode 16+** / **iOS 17+**

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/y0ussefmohamed/SwiftUI-Clones.git
   ```
2. Open `SwiftUI-Practice.xcodeproj` in Xcode
3. Build and run on a simulator or device (iOS 17+)

## Features Highlight

| Feature            | Description                                                  |
| ------------------ | ------------------------------------------------------------ |
| Pixel-perfect UI   | Closely matches the original app designs                     |
| Swipe Gestures     | Interactive card swiping with physics-based animations       |
| Micro-Animations   | Subtle animations for buttons, transitions, and interactions |
| Modular Components | Reusable, self-contained UI components                       |
| Clean Navigation   | Router-based navigation with smooth push transitions         |

## 📄 License

This project is for educational purposes only. All trademarks and brand names belong to their respective owners.
