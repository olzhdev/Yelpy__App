//
//  Business.swift
//  Yelpy
//
//  Created by MAC
//

import Foundation

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClaimed, isClosed: Bool
    let url: String
    let phone, displayPhone: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let location: Location
    let coordinates: Coordinates
    let photos: [String]
    let price: String?
    let hours: [Hour]
    let transactions: [String]?
    let messaging: Messaging?
    
    var formattedIsClosed: String {
        if isClosed {
            return "Closed"
        } else {
            return "Open Now"
        }
    }
    
    var stringRating: String {
        return String(rating)
    }
    
    var stringFormattedReviewCount: String {
        return "\(reviewCount) Reviews"
    }

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price, hours, transactions, messaging
    }
}

 // MARK: - Category
struct Category: Codable {
    let alias, title: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]
    let hoursType: String
    let isOpenNow: Bool

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool
    let start, end: String
    let day: Int

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - Location
struct Location: Codable {
    let address1, address2, address3, city: String?
    let zipCode, country, state: String?
    let displayAddress: [String]
    let crossStreets: String

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}

// MARK: - Messaging
struct Messaging: Codable {
    let url: String
    let useCaseText: String

    enum CodingKeys: String, CodingKey {
        case url
        case useCaseText = "use_case_text"
    }
}
