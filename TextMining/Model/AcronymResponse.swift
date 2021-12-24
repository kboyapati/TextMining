//
//  AcronymResponse.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/23/2021.
//

import Foundation

class AcronymsResponse: Codable {
    var searchTerm: String?
    var results: [FullForm]?

    init(searchTerm: String?, results: [FullForm]?) {
        self.searchTerm = searchTerm
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case searchTerm = "sf"
        case results = "lfs"
    }
}
