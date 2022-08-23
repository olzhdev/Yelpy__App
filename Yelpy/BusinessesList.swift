import Foundation

// MARK: - BusinessesList
struct BusinessesList: Codable {
    let total: Int
    let businesses: [BusinessItem]
    let region: Region
}

// MARK: - Business
struct BusinessItem: Codable {
    let rating: Double
    let price: String?
    let phone: String?
    let id: String
    let alias: String?
    let isClosed: Bool
    let categories: [Category1]
    let reviewCount: Int
    let name: String
    let url: String
    let coordinates: Center1
    let imageURL: String
    let location: Location1
    let distance: Double
    let transactions: [String]
    
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

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
    
}

// MARK: - Category
struct Category1: Codable {
    let alias, title: String
}

// MARK: - Center
struct Center1: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location1: Codable {
    let city, country, address2, address3: String?
    let state, address1, zipCode: String?

    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
}


// MARK: - Region
struct Region: Codable {
    let center: Center1
}



