//
//  StandingsTableViewCell.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

final class StandingsTableViewCell: UITableViewCell {
    
    static let cellId = String(describing: StandingsTableViewCell.self)
    
    var nameWidthConstraint: NSLayoutConstraint?
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var statLabels: [UILabel] = {
        var labels: [UILabel] = []
        for _ in 0..<Constant.Standings.totalStats {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .regular)
            labels.append(label)
        }
        return labels
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(standing: Standing) {
        if let logos = standing.team.logos {
            if let url = URL(string: logos[0].href) {
                NetworkService.shared.loadImage(with: url) { [self] result in
                    switch result {
                    case .success(let image):
                        logoImageView.image = image
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        nameLabel.text = standing.team.displayName
        nameLabel.sizeToFit()
        
        let isPortraitOrientation = Constant.isPortraitOrientation()
        
        for i in 0..<Constant.Standings.totalStats {
            statLabels[i].text = standing.stats[i].displayValue
            if i >= Constant.Standings.itemsCount {
                statLabels[i].isHidden = isPortraitOrientation
            }
        }
        
        var nameWidth = Constant.Standings.nameWidth
        if isPortraitOrientation == false {
            nameWidth *= 2
        }
        
        nameWidthConstraint?.constant = nameWidth
    }
    
    private func setupCell() {
        backgroundColor = .white
        selectionStyle = .gray
    }
    
    private func setupLayout() {
        addSubview(logoImageView)
        addSubview(nameLabel)
        
        logoImageView.prepareForAutoLayout()
        nameLabel.prepareForAutoLayout()
        
        let constraints = [
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Standings.inset * 2),
            logoImageView.widthAnchor.constraint(equalToConstant: Constant.Standings.logoSize),
            logoImageView.heightAnchor.constraint(equalToConstant: Constant.Standings.logoSize),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Constant.Standings.inset),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        nameWidthConstraint = nameLabel.widthAnchor.constraint(equalToConstant: Constant.Standings.nameWidth)
        nameWidthConstraint?.isActive = true
        
        var leading = Constant.Standings.inset
        for i in 0..<Constant.Standings.totalStats {
            var itemWidth = Constant.Standings.itemWidth
            if i >= Constant.Standings.totalStats - 4 { itemWidth *= 1.5 }
            if i >= Constant.Standings.totalStats - 1 { itemWidth += itemWidth }
            
            addSubview(statLabels[i])
            statLabels[i].prepareForAutoLayout()
            
            let constraints = [
                statLabels[i].centerYAnchor.constraint(equalTo: centerYAnchor),
                statLabels[i].leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: leading),
                statLabels[i].widthAnchor.constraint(equalToConstant: itemWidth),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            leading += itemWidth
        }
    }
}
