//
//  FilterModel.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 15/02/2026.
//

import Foundation


struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false),
            FilterModel(title: "Categories", isDropdown: true),
        ]
    }
}
