//
//  DefaultCategoriesConstants.swift
//  Yelpy
//
//  Created by MAC
//

import Foundation

/// All default-hardcoded categories for HomeVC
enum DefaultArrays {
    static let cuisineDefaultArray = [
        "Mexican": ["APIAttribute": "mexican",
                    "imageName": "Mexican"],
        "Chinese": ["APIAttribute": "chinese",
                    "imageName": "Chinese"],
        "Italian": ["APIAttribute": "italian",
                    "imageName": "Italian"],
        "Indian": ["APIAttribute": "indpak",
                   "imageName": "Indian"]
    ]
    static let foodTypeDefaultArray = [
        "Pizza": ["APIAttribute": "pizza",
                  "imageName": "Pizza"],
        "Pasta": ["APIAttribute": "pastashops",
                  "imageName": "Pasta"],
        "Burger": ["APIAttribute": "burgers",
                   "imageName": "Burger"],
        "Seafood": ["APIAttribute": "seafood",
                    "imageName": "Seafood"]
    ]
    static let commonTypeDefaultArray = [
        "Ice cream": ["APIAttribute": "icecream",
                      "imageName": "Icecream"],
        "Juice": ["APIAttribute": "juicebars",
                  "imageName": "Juice"],
        "Bubbletea": ["APIAttribute": "bubbletea",
                      "imageName": "Bubbletea"],
        "Desserts": ["APIAttribute": "desserts",
                     "imageName": "Dessert"]
    ]
}


