//
//  CC.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation

import Foundation
import UIKit

public struct CC<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol CCCompatible { }

public extension CCCompatible {
    static var cc: CC<Self>.Type {
        get { CC<Self>.self }
        set { }
    }
    
    var cc: CC<Self> {
        get { CC(self) }
        set { }
    }
}
