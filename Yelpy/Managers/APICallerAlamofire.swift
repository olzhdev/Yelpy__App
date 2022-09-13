//
//  APICallerAlamofire.swift
//  Yelpy
//
//  Created by MAC on 11.09.2022.
//

import Foundation
import Alamofire

final class APICallerAlamofire: APICallerProtocol {
    // MARK: - Protocol methods
    
    func getBusinessList(forCategory category: String,
                         count: Int,
                         offset: Int,
                         price: String,
                         attributes: String,
                         completion: @escaping (Result<BusinessesList, Error>) -> Void)
    {
        let URL = formURL(for: .search,
                             queryParams: ["location": "NYC",
                                           "categories": category,
                                           "limit": String(count),
                                           "price": price,
                                           "offset": String(offset),
                                           "attributes": attributes])
        doRequest(url: URL, expecting: BusinessesList.self, completion: completion)
    }
    
    func getBusinessDetail(forBusinessID id: String,
                           completion: @escaping (Result<Business, Error>) -> Void)
    {
        let URL = formURL(for: .businessSearch, queryParams: ["": id])
        doRequest(url: URL, expecting: Business.self, completion: completion)
    }
    
    
    // MARK: - Private realisations
    
    private struct Constants {
        static let baseURL = "https://api.yelp.com/v3/"
        static let headers: HTTPHeaders = [.authorization(bearerToken: "pzHNIq2VdYMqzaWJGFabtzj2uXYWKfVujk_372Od0kxrArIURUzSO64hiFbT25C1vkkL0J9F-gvQ8iOBzKCiNZ5ldqVR-sfP1XkRO4WHAn4rw0AMdGzOllC1eWLZYnYx")]
    }

    private enum Endpoint: String {
        case search = "businesses/search"
        case businessSearch = "businesses/"
    }
    
    private func formURL(for endpoint: Endpoint,
                         queryParams: [String:String] = [:]) -> String
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

        return urlString
    }
 

    private func doRequest<T: Codable>(url: String,
                                      expecting: T.Type,
                                      completion: @escaping(Result<T, Error>) -> Void)
    {
        AF.request(url, headers: Constants.headers).responseDecodable(of: expecting)
        { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
