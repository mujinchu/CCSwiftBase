//
//  CCUITableView.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation
import UIKit

extension CC where Base: UITableView {
    /// 注册自定义cell
    /// - Parameter cellClass: UITableViewCell类型
    func register(with cell: UITableViewCell.Type) {
        base.register(cell.self, forCellReuseIdentifier: cell.className)
    }
    
    /// 注册Xib自定义cell
    /// - Parameter nib: nib description
    func register(with nib: String) {
        base.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: UITableViewCell {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.className) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }
}
