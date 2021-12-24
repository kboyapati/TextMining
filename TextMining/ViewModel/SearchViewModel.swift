//
//  SearchViewModel.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/23/2021.
//

import UIKit
import Alamofire
import Combine

enum LoadingState {
    case loading
    case finished
    case noDataFound
    case failure(Error)
}

class SearchViewModel: ViewModelBase<FullFormCellViewModel> {
    
    private var state: LoadingState = .finished {
        didSet {
            dataLoadingState?(state)
        }
    }
    var dataLoadingState: ((LoadingState)->Void)? = nil
    
    func search(text: String, isAbbriviation: Bool) {
        let endPoint: SearchEndPoint = !isAbbriviation ?
            .searchFullForm(fullForm: text) :
            .searchShortForm(shortForm: text)
        
        state = .loading
        NetworkManager.shared.request(endPoint: endPoint) { [weak self] (response: Result<[AcronymsResponse], AFError>) in
            switch response {
            case .success(let data):
                self?.dataSource = data.first?.results?.compactMap({ FullFormCellViewModel(fullForm: $0) }) ?? [FullFormCellViewModel]()
                self?.state = (self?.dataSource?.count == 0) ? .noDataFound : .finished
            case .failure(let error):
                print(error.localizedDescription)
                self?.state = .failure(error)
            }
        }
    }
    
    func reset() {
        self.dataSource?.removeAll()
        self.state = .finished
    }
}
