//
//  CCUIColor.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation

extension UIColor: CCCompatible { }

extension UIColor  {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 十六进制字符串 转颜色
    /// - Parameter hexString: 十六进制字符串
    /// - 必须是 #204282 或者 204282 类似字符串
    convenience init(hex: String) {
        let string = hex.uppercased()
        let scanner = Scanner(string: string)
        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(color & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    /// 十六进制数 转颜色
    /// - Parameter hexInt: 十六进制数
    convenience init(hex: Int) {
        let r = CGFloat(((hex & 0x00FF0000) >> 16)) / 255.0
        let g = CGFloat(((hex & 0x0000FF00) >> 8)) / 255.0
        let b = CGFloat(hex & 0x000000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension CC where Base == UIColor {
    /// 颜色生成图片
    /// - Returns: 图片
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(base.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
