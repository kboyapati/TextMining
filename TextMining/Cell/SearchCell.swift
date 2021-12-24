//
//  SearchCell.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import UIKit

class SearchCell: UITableViewCellBase<FullFormCellViewModel> {
    override func configure() {
        if #available(iOS 14, *) {
            var config = self.defaultContentConfiguration()
            config.text = viewModel?.text
            self.contentConfiguration = config
        } else {
            textLabel?.text = viewModel?.text
        }
        // If the viewmodel has variations then enable the indiactor
        accessoryType = (viewModel?.haveVariations ?? false) ? .disclosureIndicator : .none
    }
}
