//
//  CCUICollectionView.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation
import UIKit

extension CC where Base: UICollectionView {
    func register(with cell: UICollectionViewCell.Type) {
        base.register(cell.self, forCellWithReuseIdentifier: cell.className)
    }
    
    func register(with nib: String) {
        base.register(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
    }
    
    func registerHeader(with cell: UICollectionViewCell.Type) {
        base.register(cell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cell.className)
    }
    
    func registerHeader(with nib: String) {
        base.register(UINib(nibName: nib, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nib)
    }
    
    func registerFooter(with cell: UICollectionViewCell.Type) {
        base.register(cell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cell.className)
    }
    
    func registerFooter(with nib: String) {
        base.register(UINib(nibName: nib, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nib)
    }
}

extension CC where Base: UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.className)")
        }
        return cell
    }
    
    func dequeueReusableHeaderView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let header = base.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable header view with identifier: \(T.className)")
        }
        return header
    }
    
    func dequeueReusableFooterView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let header = base.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable footer view with identifier: \(T.className)")
        }
        return header
    }
}
