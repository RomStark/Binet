//
//  DrugCollectionViewCell.swift
//  Binet
//
//  Created by Al Stark on 30.04.2023.
//

import UIKit
import Kingfisher

final class DrugCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "DrugCollectionViewCell"
    private var imageView: UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension DrugCollectionViewCell {
    func configureCell(drug: Drug) {
        
        self.titleLabel.text = drug.categories.name
        self.descriptionLabel.text = drug.description
        let urlString = "http://shans.d2.i-partner.ru" + drug.categories.image
        if  let urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
           let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        } else {

            imageView.image = nil
        }
    }
}

private extension DrugCollectionViewCell {
    private func setupUI() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
//        contentView.layer.shadowColor = .init(gray: 0.5, alpha: 0.5)
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderColor = .init(red: (72.0/255), green: (76.0/255), blue: (76.0/255), alpha: 0.15)
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 82.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0).isActive = true
        
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
       
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0).isActive = true
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0).isActive = true
    }
    
    
}
