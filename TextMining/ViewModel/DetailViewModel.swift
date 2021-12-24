//
//  DetailViewModel.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import Foundation

class DetailViewModel: ViewModelBase<FullFormCellViewModel> {
    
    init(dataSource: [FullFormCellViewModel]) {
        super.init()
        self.dataSource = dataSource
    }
}
