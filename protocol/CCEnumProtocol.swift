//
//  CCEnumProtocol.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/8.
//

import Foundation

protocol CCEnumProtocol: RawRepresentable, Codable where RawValue: Codable {
    static var `default`: Self { get }
    
    var description: String { get }
}

extension CCEnumProtocol {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let decoded = try container.decode(RawValue.self)
            self = Self.init(rawValue: decoded) ?? Self.`default`
        } catch {
            self = Self.`default`
        }
    }
    
    var description: String {
        ""
    }
}

