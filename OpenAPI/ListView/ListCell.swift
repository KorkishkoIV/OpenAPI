//
//  ListCell.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 26.01.2023.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let reuseID = "ListCell"
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(sourceLabel)
        contentView.addSubview(titleLabel)
        setupConstains()
    }
    
    private func setupConstains() {
        let sourceHeight = sourceLabel.font.lineHeight
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            sourceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            sourceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            sourceLabel.heightAnchor.constraint(equalToConstant: sourceHeight)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.lastBaselineAnchor,constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setModel(_ model: Any) {
        guard let article = model as? Article else {
            return
        }
        sourceLabel.text = article.source?.name
        titleLabel.text = article.title
    }
    
    
    
}
