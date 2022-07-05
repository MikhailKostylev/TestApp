//
//  Constants.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

enum Constant {
    
    static let mainUrl = "https://api-football-standings.azharimm.site"
    
    static func isPortraitOrientation() -> Bool {
        let size = UIScreen.main.bounds.size
        return size.width < size.height
    }
    
    static func getInset(view: UIView) -> CGFloat {
        var inset: CGFloat = 0
        if let window = view.window?.windowScene?.windows.first(where: {$0.isKeyWindow }) {
            let insets = window.safeAreaInsets
            if inset < insets.top { inset = insets.top }
            if inset < insets.bottom { inset = insets.bottom }
            if inset < insets.left { inset = insets.left }
            if inset < insets.right { inset = insets.right }
            if inset < 44 { inset = 0 }
        }
        return inset
    }
    
    enum Leagues {
        static let columnsPortrait: CGFloat = 2
        static let columnsLandscape: CGFloat = 4
        static let titleHeight: CGFloat = 60
    }
    
    enum Standings {
        static let totalStats = 13
        static let inset: CGFloat = 6
        static let logoSize: CGFloat = 30
        static let nameWidth: CGFloat = 100
        static let teamFieldWidth = 2 * inset + logoSize + inset + nameWidth
        static let itemWidth: CGFloat = 23
        static let itemsCount: Int = {
            let b = UIScreen.main.bounds
            let lesserValue = b.width < b.height ? b.width : b.height
            return Int((lesserValue - teamFieldWidth) / itemWidth)
        }()
    }
}
