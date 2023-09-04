//
//  ViewExtention.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 03.09.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubViews(views: [UIView]) {
        for i in views {
            addSubview(i)
        }
    }
}
