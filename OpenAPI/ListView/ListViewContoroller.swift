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
        
        navigationItem.title = "List"
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
        cell.setModel(item)
        return cell    
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm?.showDetailsForItemAtindex(index: indexPath.row)
    }
}
