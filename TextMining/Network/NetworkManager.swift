//
//  NetworkManager.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/23/2021.
//

import Foundation
import Alamofire

protocol EndPoint {
    var baseUrl: String { get }
    var url: String { get }
    var path: String { get }
    var parameters: Parameters { get }
    var method: HTTPMethod { get }
}

extension EndPoint {
    var baseUrl: String {
        return "http://nactem.ac.uk/"
    }
    
    var url: String {
        return baseUrl + path
    }
    
    var parameters: Parameters {
        return Parameters()
    }
    
    var method: HTTPMethod {
        return .get
    }
}

enum SearchEndPoint: EndPoint {
    case searchShortForm(shortForm: String)
    case searchFullForm(fullForm: String)
    
    var path: String {
        return "software/acromine/dictionary.py"
    }
    
    var parameters: Parameters {
        var params = Parameters()
        switch self {
        case .searchShortForm(let searchTerm):
            params["sf"] = searchTerm
        case .searchFullForm(let searchTerm):
            params["lf"] = searchTerm
        }
        return params
    }
}

class NetworkManager {
    
    static var shared: NetworkManager = NetworkManager()
    
    private init() {
        
    }
    
    func request<T: Codable>(endPoint: EndPoint, completion: @escaping (Result<T, AFError>)->Void) {
        AF.request(endPoint.url,
                   method: endPoint.method,
                   parameters: endPoint.parameters)
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
}
