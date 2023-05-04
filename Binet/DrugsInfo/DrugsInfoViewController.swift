//
//  DrugsInfoViewController.swift
//  Binet
//
//  Created by Al Stark on 04.05.2023.
//

import UIKit
import Kingfisher

final class DrugsInfoViewController: UIViewController {

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "title"
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .init(red: (174.0/255), green: (176.0/255), blue: (182.0/255), alpha: 1.0)
        label.text = "decription"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .green
        
        setupUI()
        
    }
    

}

extension DrugsInfoViewController {
    func configure(drug: Drug) {
        
        self.titleLabel.text = drug.name
        self.descriptionLabel.text = drug.description
        let urlString = "http://shans.d2.i-partner.ru" + drug.image
        if  let urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
           let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        } else {

            imageView.image = nil
        }
        let urlStringIcon = "http://shans.d2.i-partner.ru" + drug.categories.icon
        if  let urlStringIcon = urlStringIcon.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
           let url = URL(string: urlStringIcon) {
            iconImageView.kf.setImage(with: url)
        } else {

            iconImageView.image = nil
        }
        
    }
}

private extension DrugsInfoViewController {
    private func setupUI() {
        setupImageView()
        setupIconImageView()
        setupIconImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    private func setupImageView() {
        view.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 182.0).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func setupIconImageView() {
        view.addSubview(iconImageView)
        
        iconImageView.contentMode = .scaleAspectFit
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0).isActive = true
        
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
      
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30.0).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 82.0).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0).isActive = true
        
    }
    
    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0).isActive = true
    }
}
