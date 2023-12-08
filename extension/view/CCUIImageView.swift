//
//  CCUIImageView.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation

extension UIImageView {
    @discardableResult
    func imageName(_ imageName: String?) -> Self {
        self.image = UIImage(named: imageName ?? "")
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
}

extension CC where Base: UIImageView {
    func setImage(for name: String?) {
        guard let name = name else { return }
        base.image = UIImage(named: name)
    }
}
