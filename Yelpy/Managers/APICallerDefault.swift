//
//  APICaller.swift
//  Yelpy
//
//  Created by MAC
//

import Foundation

protocol APICallerProtocol {
    func getBusinessList(
        forCategory category: String,
        count: Int,
        offset: Int,
        price: String,
        attributes: String,
        completion: @escaping (Result<BusinessesList, Error>) -> Void)
    
    func getBusinessDetail(
        forBusinessID id: String,
        completion: @escaping (Result<Business, Error>) -> Void)
}


/// Object to manage all API calls
final class APICallerDefault: APICallerProtocol {
    // MARK: - Methods

    /// Get list of businesses for given attributes
    /// - Parameters:
    ///   - category: Category name
    ///   - count: Count of returned results
    ///   - offset: Offset for pagination
    ///   - price: Price filter (1,2,3,4)
    ///   - completion: Callback
    func getBusinessList(
        forCategory category: String,
        count: Int,
        offset: Int,
        price: String = "1,2,3,4",
        attributes: String,
        completion: @escaping (Result<BusinessesList, Error>) -> Void)
    {
        
        let request = requestWithURL(
            for: .search,
               queryParams: ["location": "NYC",
                             "categories": category,
                             "limit": String(count),
                             "price": price,
                             "offset": String(offset),
                             "attributes": attributes])
            
        doRequest(request: request,
                  expecting: BusinessesList.self,
                  completion: completion)
    }

    /// Get detailed information of business
    /// - Parameters:
    ///   - id: ID of given business
    ///   - completion: Callback
    func getBusinessDetail(
        forBusinessID id: String,
        completion: @escaping (Result<Business, Error>) -> Void)
    {
        let request = requestWithURL(
                for: .businessSearch,
                queryParams: ["": id])
            
        doRequest(request: request,
                  expecting: Business.self,
                  completion: completion)
    }
    
    
    // MARK: - Private
    
    private struct Constants {
        static let baseURL = "https://api.yelp.com/v3/"
        static let APIKey = "Bearer pzHNIq2VdYMqzaWJGFabtzj2uXYWKfVujk_372Od0kxrArIURUzSO64hiFbT25C1vkkL0J9F-gvQ8iOBzKCiNZ5ldqVR-sfP1XkRO4WHAn4rw0AMdGzOllC1eWLZYnYx"
    }
    
    private enum Endpoint: String {
        case search = "businesses/search"
        case businessSearch = "businesses/"
    }
    
    private enum APIError: Error {
        case invalidUrl
        case noDataReturned
        case decodingError
    }
    
    /// Forming url from attributes and returns request
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - queryParams: Given attributes
    /// - Returns: URLRequest: [...businesses/search?location=NYC&categories=bars] or [...businesses/id]
    private func requestWithURL(
        for endpoint: Endpoint,
        queryParams: [String:String] = [:]) -> URLRequest?
    {
    
        var urlString = Constants.baseURL + endpoint.rawValue
        var queryItems = [URLQueryItem]()
        var queryString = ""
        
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        if endpoint == .businessSearch {
            queryString = queryItems.map {"\($0.name)\($0.value ?? "")"}.joined(separator: "")
            urlString += queryString
            
        } else if endpoint == .search {
            queryString = queryItems.map {"\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
            urlString += "?" + queryString
        }

        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.addValue(Constants.APIKey, forHTTPHeaderField: "Authorization")
        //print(request)
        return request
    }
    
    
    /// Fetches call with given request and decodes with preferred model
    private func doRequest<T: Codable> (
        request: URLRequest?,
        expecting: T.Type,
        completion: @escaping(Result<T, Error>) -> Void)
    {
        
        guard let request = request else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(APIError.decodingError))
            }
        }
        task.resume()
    }
}
    
