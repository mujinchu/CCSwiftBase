//
//  CCUIView.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation
import UIKit

extension UIView: CCCompatible { }

extension CC where Base: UIView {
    
    public var left: CGFloat {
        get {
            base.frame.origin.x
        } set {
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
    }
    
    public var right: CGFloat {
        get {
            return left + width
        }
    }
    
    public var top: CGFloat {
        get {
            base.frame.origin.y
        } set {
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
    }
    
    public var bottom: CGFloat {
        get {
            top + height
        }
    }
    
    public var width: CGFloat {
        get {
            base.frame.size.width
        } set {
            var frame = base.frame
            frame.size.width = newValue
            base.frame = frame
        }
    }
    
    public var height: CGFloat {
        get {
            base.frame.size.height
        } set {
            var frame = base.frame
            frame.size.height = newValue
            base.frame = frame
        }
    }
    
    public var size: CGSize {
        get {
            return base.frame.size
        } set {
            var frame = base.frame
            frame.size = newValue
            base.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        get {
            base.center.x
        } set {
            var center = base.center
            center.x = newValue
            base.center = center
        }
    }
    
    public var centerY: CGFloat {
        get {
            base.center.y
        } set {
            var center = base.center
            center.y = newValue
            base.center = center
        }
    }
}

extension CC where Base: UIView {
    /// 圆角
    var cornerRadius: CGFloat {
        get {
            base.layer.cornerRadius
        } set {
            base.layer.masksToBounds = newValue > 0
            base.layer.cornerRadius = newValue
        }
    }
    
    /// 边线宽度
    var borderWidth: CGFloat {
        get {
            base.layer.borderWidth
        } set {
            base.layer.borderWidth = newValue
        }
    }
    
    /// 边线颜色
    var borderColor: UIColor {
        get {
            UIColor(cgColor: base.layer.borderColor!)
        } set {
            base.layer.borderColor = newValue.cgColor
        }
    }
}

extension UIView {
    @discardableResult
    func backgroundColor(_ value: Int) -> Self {
        backgroundColor = UIColor(hex: value)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ value: String) -> Self {
        backgroundColor = UIColor(hex: value)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func cornerRadius(_ value: CGFloat) -> Self {
        layer.masksToBounds = value > 0
        layer.cornerRadius = value
        return self
    }
    
    @discardableResult
    func borderWidth(_ value: CGFloat) -> Self {
        layer.borderWidth = value
        return self
    }
    
    @discardableResult
    func borderColor(_ color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func borderColor(_ value: Int) -> Self {
        layer.borderColor = UIColor(hex: value).cgColor
        return self
    }
    
    @discardableResult
    func borderColor(_ value: String) -> Self {
        layer.borderColor = UIColor(hex: value).cgColor
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value
        return self
    }
}

typealias CCGestureRecognizer = () -> Void
typealias CCLongPressGestureRecognizer = (_ sender: UILongPressGestureRecognizer) -> Void

extension UIView {
    private struct AssociatedKeys {
        static var tapGestureKey = UnsafeRawPointer.init(bitPattern: "CCTapGestureKey".hashValue)
        static var tapDelay = UnsafeRawPointer.init(bitPattern: "CCTapDelayKey".hashValue)
        static var longPressGestureKey = UnsafeRawPointer.init(bitPattern: "CCLongPressGestureKey".hashValue)
    }
    
    // MARK: - UITapGestureRecognizer
    @objc dynamic var tapGestureHanler: CCGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tapGestureKey) as? CCGestureRecognizer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tapGestureKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    @objc dynamic var tapDelay: TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tapDelay, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tapDelay) as? TimeInterval ?? 0
        }
    }
    
    @objc private func viewTapAction() {
        guard let tapGestureHanler = tapGestureHanler else { return }
        tapGestureHanler()
    }
    
    func taped(_ tapGestureHanler: @escaping CCGestureRecognizer) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapAction))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        self.tapGestureHanler = tapGestureHanler
    }
    
    // MARK: - UILongPressGestureRecognizer
    @objc dynamic var longPressGestureHanler: CCLongPressGestureRecognizer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.longPressGestureKey) as? CCLongPressGestureRecognizer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.longPressGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func longPressAction(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began, let longPressGestureHanler = longPressGestureHanler else { return }
        longPressGestureHanler(sender)
    }
    
    func longPressed(_ longPressHandle: @escaping CCLongPressGestureRecognizer) {
        self.isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        longPress.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPress)
        self.longPressGestureHanler = longPressHandle
    }
}
