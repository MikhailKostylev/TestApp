//
//  SeasonsTableViewCell.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

final class SeasonsTableViewCell: UITableViewCell {
    
    static let cellId = String(describing: SeasonsTableViewCell.self)
    
    private let padding: CGFloat = 12
    
    lazy var view = UIView()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Resources.Colors.appGreen
        selectionStyle = .none
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(season: Season) {
        setupNameLabel(season: season)
        setupDateLabel(season: season)
        setupLayout()
    }
    
    private func setupNameLabel(season: Season) {
        nameLabel.text = "\(season.displayName)"
        nameLabel.sizeToFit()
    }
    
    private func setupDateLabel(season: Season) {
        let dateFormatter = DateFormatter()
        dateLabel.text = "Year: \(season.year)\nSeason time: \(dateFormatter.inStatFormatDate(date: season.startDate)) - \(dateFormatter.inStatFormatDate(date: season.endDate))"
    }
    
    private func setupLayout() {
        addSubview(view)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        
        view.prepareForAutoLayout()
        nameLabel.prepareForAutoLayout()
        dateLabel.prepareForAutoLayout()
        
        let constraints = [
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
