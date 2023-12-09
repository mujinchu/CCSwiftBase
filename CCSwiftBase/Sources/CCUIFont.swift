//
//  CCUIFont.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/9.
//

import Foundation
import UIKit

extension UIFont: CCCompatible { }

extension CC where Base: UIFont {
    static func font(_ value: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: value, weight: weight)
    }
}
