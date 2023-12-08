//
//  CCUIButton.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation

extension UIButton {
    @discardableResult
    func title(_ text: String?, for state: UIControl.State = .normal) -> Self {
        setTitle(text, for: state)
        return self
    }
    
    @discardableResult
    func textColor(_ value: Int, for state: UIControl.State = .normal) -> Self {
        setTitleColor(UIColor(hex: value), for: state)
        return self
    }
    
    @discardableResult
    func textColor(_ value: String, for state: UIControl.State = .normal) -> Self {
        setTitleColor(UIColor(hex: value), for: state)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func selected(_ value: Bool) -> Self {
        isSelected = value
        return self
    }
    
    @discardableResult
    func font(_ value: CGFloat, weight: UIFont.Weight) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: value, weight: weight)
        return self
    }

    @discardableResult
    func image(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func image(_ imageName: String?, for state: UIControl.State = .normal) -> Self {
        guard let imageName = imageName else { return self }
        setImage(UIImage(named: imageName), for: state)
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ inset: UIEdgeInsets) -> Self{
        titleEdgeInsets = inset
        return self
    }
    
    @discardableResult
    func contentEdgeInsets(_ inset: UIEdgeInsets) -> Self{
        contentEdgeInsets = inset
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ inset: UIEdgeInsets) -> Self{
        imageEdgeInsets = inset
        return self
    }
    
    @discardableResult
    func backgroundImage(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(color.cc.toImage(), for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ value: Int, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(UIColor(hex: value).cc.toImage(), for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ value: String, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(UIColor(hex: value).cc.toImage(), for: state)
        return self
    }
}

typealias ButtonActionBlock = (() -> Void)

extension UIButton {

    private struct AssociatedKeys {
        static var actionBlock = UnsafeRawPointer.init(bitPattern: "ButtonActionBlock".hashValue)
        static var actionDelay = UnsafeRawPointer.init(bitPattern: "ButtonActionDelay".hashValue)
    }
    
    /// 运行时关联
    private var actionBlock: ButtonActionBlock? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.actionBlock) as? ButtonActionBlock
        }
    }
    
    private var actionDelay: TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.actionDelay, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.actionDelay) as? TimeInterval ?? 0
        }
    }
    
    /// 点击回调
    @objc private func btnDelayClick(_ button: UIButton) {
        actionBlock?()
        isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + actionDelay) { [weak self] in
            print("恢复时间\(Date())")
            self?.isEnabled = true
        }
    }
    
    /// 添加点击事件
    func action(_ delay: TimeInterval = 1, action: @escaping ButtonActionBlock) {
        addTarget(self, action: #selector(btnDelayClick(_:)) , for: .touchUpInside)
        actionDelay = delay
        actionBlock = action
    }
}
