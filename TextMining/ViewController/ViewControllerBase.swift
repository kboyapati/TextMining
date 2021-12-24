//
//  ViewControllerBase.swift
//  TextMining
//
//  Created by Naga Kokila Boyapati on 12/24/2021.
//

import UIKit
import MBProgressHUD

class ViewControllerBase<T: NSObject, U: UITableViewCellBase<T>>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var viewModel: ViewModelBase<T>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String, message: String, actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({ alert.addAction($0) })
        self.present(alert, animated: true, completion: nil)
    }
    // using MBProgressHUD to show and hide the activity indicator
    func showProgressHud() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgressHud() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
//MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: U.self), for: indexPath) as! U
        cell.viewModel = viewModel?.model(at: indexPath.row)
        return cell
    }
}
