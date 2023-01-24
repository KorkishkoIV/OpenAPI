//
//  ListViewContorller.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 23.01.2023.
//

import Foundation
import UIKit

protocol pListViewController: AnyObject {
    
}

final class ListViewController: UIViewController, pListViewController {
    var vm: pListVM?
    
    private var listTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.dataSource = self
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.itemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
