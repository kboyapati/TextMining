//
//  FullFormCellViewModel.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import Foundation

class FullFormCellViewModel: NSObject {
    private var fullForm: FullForm
    init(fullForm: FullForm) {
        self.fullForm = fullForm
    }
    
    var text: String {
        return fullForm.fullForm ?? ""
    }
    
    var haveVariations: Bool {
        fullForm.variations?.count != 0
    }
    
    var variations: [FullFormCellViewModel] {
        return fullForm.variations?.compactMap({ FullFormCellViewModel(fullForm: $0) }) ?? [FullFormCellViewModel]()
    }
}
