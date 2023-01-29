//
//  DetailsViewController.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

import Foundation
import UIKit

protocol pDetailsViewController: AnyObject {
    func setArticleImage(_ image: UIImage)
}

final class DetailsViewContorller: UIViewController, pDetailsViewController {
    var vm: pDetailsViewModel?
    
    private var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        navigationItem.title = "Details"
        
        view.addSubview(articleImageView)
        view.addSubview(titleLabel)
        view.addSubview(publishDateLabel)
        view.addSubview(authorLabel)
        view.addSubview(contentLabel)
        
        setupConstarints()
    }
    
    private func fetchData() {
        guard let model = vm else {
            return
        }
        
        titleLabel.text = model.title()
        publishDateLabel.text = model.publishDateString()
        authorLabel.text = model.authorString()
        contentLabel.text = model.presentationContent()
        
        vm?.fetchArticleImage()
    }
    
    private func setupConstarints() {
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            articleImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            articleImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: titleLabel.font.lineHeight * 3),
            titleLabel.leftAnchor.constraint(equalTo: articleImageView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: articleImageView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            publishDateLabel.topAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor, constant: 10),
            publishDateLabel.heightAnchor.constraint(equalToConstant: publishDateLabel.font.lineHeight),
            publishDateLabel.leftAnchor.constraint(equalTo: articleImageView.leftAnchor),
            publishDateLabel.rightAnchor.constraint(equalTo: articleImageView.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: publishDateLabel.lastBaselineAnchor, constant: 5),
            authorLabel.heightAnchor.constraint(equalToConstant: authorLabel.font.lineHeight),
            authorLabel.leftAnchor.constraint(equalTo: articleImageView.leftAnchor),
            authorLabel.rightAnchor.constraint(equalTo: articleImageView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: authorLabel.lastBaselineAnchor, constant: 10),
            contentLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            contentLabel.leftAnchor.constraint(equalTo: articleImageView.leftAnchor),
            contentLabel.rightAnchor.constraint(equalTo: articleImageView.rightAnchor)
        ])
        
    }
    
    func setArticleImage(_ image: UIImage) {
        articleImageView.image = image
    }
}
