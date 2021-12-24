//
//  FullForm.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/23/2021.
//

import Foundation

class FullForm: Codable {
    var fullForm: String?
    var freq, since: Int?
    var variations: [FullForm]?

    init(fullForm: String?, freq: Int?, since: Int?, variations: [FullForm]?) {
        self.fullForm = fullForm
        self.freq = freq
        self.since = since
        self.variations = variations
    }
    
    enum CodingKeys: String, CodingKey {
        case freq
        case since
        case fullForm = "lf"
        case variations = "vars"
    }
}
