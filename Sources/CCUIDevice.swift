//
//  CCUIDevice.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation
import UIKit

extension UIDevice: CCCompatible { }

extension CC where Base == UIDevice {
    /// 顶部安全高度
    static var safeAreaTop: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return 0 }
        return window.safeAreaInsets.top
    }
    
    /// 底部安全区高度
    static var safeAreaBottom: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return 0 }
        return window.safeAreaInsets.bottom
    }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let statusBarManager = windowScene.statusBarManager else { return 0 }
        return statusBarManager.statusBarFrame.height
    }
    
    /// 导航栏高度
    static var navigationBarHeight: CGFloat {
        return 44.0
    }
    
    /// 状态栏+导航栏的高度
    static var navigationFullHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
    
    /// 底部导航栏高度
    static var tabBarHeight: CGFloat {
        return 49.0
    }
    
    /// 底部导航栏高度（包括安全区）
    static var tabBarFullHeight: CGFloat {
        return tabBarHeight + safeAreaBottom
    }
}
