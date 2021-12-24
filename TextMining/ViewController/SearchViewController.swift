//
//  ViewController.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/23/2021.
//

import UIKit

class SearchViewController: ViewControllerBase<FullFormCellViewModel, SearchCell> {
        
    @IBOutlet var searchBar: UISearchBar!
    
    private var searchViewModel: SearchViewModel {
        return (viewModel as! SearchViewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = SearchViewModel()
        
        searchViewModel.dataLoadingState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showProgressHud()
            case .finished:
                self.tableView.reloadData()
                self.hideProgressHud()
            case .noDataFound:
                self.hideProgressHud()
                let searchTerm = self.searchBar.text ?? ""
                self.showAlert(title: "No Data", message: "No data found for \(searchTerm)", actions: UIAlertAction(title: "Ok", style: .default, handler: nil))
            case .failure(let error):
                
                self.showAlert(title: "Error", message: error.localizedDescription, actions: UIAlertAction(title: "Ok", style: .default, handler: nil))
                break
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow, let destination  = segue.destination as? SearchDetailViewController {
            let cellViewModel = searchViewModel.model(at: indexPath.row)
            destination.title = cellViewModel?.text
            destination.viewModel = DetailViewModel(dataSource: cellViewModel!.variations)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchViewModel.reset()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        if text.count > 1 {
            self.searchViewModel.search(text: searchBar.text ?? "", isAbbriviation: searchBar.selectedScopeButtonIndex == 0)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.searchBar.placeholder = selectedScope == 0 ? "Search Abbreviation" : "Search Initialism"
        self.searchBar.text = ""
        self.searchViewModel.reset()
    }
}
