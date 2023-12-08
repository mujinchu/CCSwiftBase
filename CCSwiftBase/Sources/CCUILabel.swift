//
//  CCUILabel.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation

extension UILabel {
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func textColor(_ value: String) -> Self {
        textColor = UIColor(hex: value)
        return self
    }
    
    @discardableResult
    func textColor(_ value: Int) -> Self {
        textColor = UIColor(hex: value)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat) -> Self {
        self.font = .systemFont(ofSize: fontSize)
        return self
    }
    
    @discardableResult
    func font(_ fontSize: CGFloat, weight: UIFont.Weight = .regular) -> Self {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return self
    }
        
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ value: Bool) -> Self {
        adjustsFontSizeToFitWidth = value
        return self
    }
    
    @discardableResult
    func attributes(with text: String?, font: UIFont, foregroundColor: UIColor, lineSpace: CGFloat, alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byWordWrapping, deleteLine: Bool = false) -> Self {
        guard let text = text else { return self }
        
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpace
        paraph.lineBreakMode = lineBreakMode
        paraph.alignment = alignment
    
        var attributes: [NSAttributedString.Key: Any] = [.font: font,
                                                         .foregroundColor: foregroundColor,
                                                         .paragraphStyle: paraph]
        if deleteLine {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
            attributes[.underlineColor] = foregroundColor
        }
        
        attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        return self
    }
}

extension CC where Base: UILabel {
    func addAttribute(with string: String?, font: UIFont, foregroundColor: UIColor, lineSpace: CGFloat, alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byWordWrapping, deleteLine: Bool = false) {
        base.attributes(with: string, font: font, foregroundColor: foregroundColor, lineSpace: lineSpace, alignment: alignment, lineBreakMode: lineBreakMode, deleteLine: deleteLine)
    }
}
