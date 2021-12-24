//
//  UITableViewCellBase.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import UIKit

class UITableViewCellBase<T>: UITableViewCell {
    var viewModel: T? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        
    }
}
