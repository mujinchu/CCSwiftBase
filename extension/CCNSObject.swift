//
//  CCNSObject.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation
import UIKit

extension NSObject {
    /// 类名（对象方法）
    var className: String {
        return type(of: self).className
    }
    
    /// 类名（类方法）
    static var className: String {
        return String(describing: self)
    }
    
    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return nil }
        return window
    }
    
    var currentViewController: UIViewController? {
        get {
            guard let window = window else { return nil }

            var vc = window.rootViewController
            while true {
                if (vc?.isKind(of: UITabBarController.classForCoder()))! {
                    let newVc = vc as! UITabBarController
                    vc = newVc.selectedViewController
                }
                
                if (vc?.isKind(of: UINavigationController.classForCoder()))! {
                    let newVc = vc as! UINavigationController
                    vc = newVc.visibleViewController
                }
                
                if vc?.presentedViewController != nil {
                    vc = vc?.presentedViewController
                } else {
                    break
                }
            }
            return vc
        }
    }
}


