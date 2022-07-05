//
//  UINavigationItem+Ext.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

extension UINavigationItem {
    func setTitle(with name: String) {
        let titleLabel = UILabel()
        titleLabel.text = name
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        titleLabel.textColor = .white
        titleView = titleLabel
    }
}
