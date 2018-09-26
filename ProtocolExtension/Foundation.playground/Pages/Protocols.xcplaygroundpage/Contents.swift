//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

struct llll: ExpressibleByArrayLiteral {
    associaltedtype ArrayLiteralElement = Int
    var i: ArrayLiteralElement

    public init(arrayLiteral elements: Self.ArrayLiteralElement) {
        i = elements
    }
}
