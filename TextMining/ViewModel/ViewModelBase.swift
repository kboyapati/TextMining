//
//  ViewModelBase.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import Foundation

class ViewModelBase<T>: NSObject {
    
    internal var dataSource: [T]?
    
    var rows: Int {
        return dataSource?.count ?? 0
    }
    
    func model(at index: Int) -> T? {
        if index < (dataSource?.count ?? 0) {
            return dataSource?[index]
        }
        return nil
    }
}
