//
//  ListViewContorller.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 23.01.2023.
//

import Foundation
import UIKit

protocol pListViewController: AnyObject {
    func reload()
}

final class ListViewController: UIViewController, pListViewController {
    var vm: pListVM?
    
    private var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        vm?.fetchItems()
    }
    
    private func setupViews() {
        view.addSubview(listTableView)
        view.backgroundColor = .white
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.refreshControl = {
            let refresh = UIRefreshControl()
             refresh.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
             return refresh
         }()
        
        if vm?.itemsCount() == 0 {
            listTableView.refreshControl?.beginRefreshing()
        }
        
        navigationItem.title = "Articles list"
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func reload() {
        listTableView.reloadData()
        listTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func refresh(_ sender:AnyObject) {
        vm?.reloadItems()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.itemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID) as? ListCell,
              let item = vm?.item(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.setModel(item)
        return cell    
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm?.showDetailsForItemAtindex(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
