//
//  CCUIFont.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/8.
//

import Foundation
import UIKit
 
extension UIFont: CCCompatible { }

extension CC where Base == UIFont {
    static func font(_ ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: weight)
    }
}
 
