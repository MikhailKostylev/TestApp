//
//  LeaguesCollectionViewCell.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

final class LeaguesCollectionViewCell: UICollectionViewCell {
    
    static let cellId = String(describing: LeaguesCollectionViewCell.self)
    
    private let padding: CGFloat = 5
    private let separatorHeight: CGFloat = 1
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        return separator
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(league: League) {
        setupLabel(league: league)
        
        if let url = URL(string: league.logos.light) {
            loadImage(url: url)
        }
        
        setupLayout()
    }
    
    private func setupLabel(league: League) {
        nameLabel.text = "\(league.name) (\(league.abbr))"
        nameLabel.sizeToFit()
    }
    
    private func loadImage(url: URL) {
        NetworkService.shared.loadImage(with: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.logoImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupLayout() {
        addSubview(logoImageView)
        addSubview(separator)
        addSubview(nameLabel)
        
        logoImageView.prepareForAutoLayout()
        separator.prepareForAutoLayout()
        nameLabel.prepareForAutoLayout()
        
        let constraints = [
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor),
            
            separator.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            separator.heightAnchor.constraint(equalToConstant: separatorHeight),
            
            nameLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
