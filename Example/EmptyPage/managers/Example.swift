//
//  Example.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/9/7.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class Example<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExampleCompatible {
    associatedtype ExampleCompatibleType
    var ex: Example<ExampleCompatibleType> { get }
}

public extension ExampleCompatible {
    var ex: Example<Self> { return Example(self) }
}

extension UIView: ExampleCompatible { }
