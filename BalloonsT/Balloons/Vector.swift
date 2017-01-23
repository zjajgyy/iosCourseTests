//
//  vector.swift
//  Balloons
//
//  Created by Yanping Zhao on 11/29/16.
//  Copyright © 2016 Yanping Zhao. All rights reserved.
//

import Foundation
import CoreGraphics

typealias Scalar = CGFloat

struct Vector {
    var x: Scalar = 0.0
    var y: Scalar = 0.0
}

extension Vector {
    static func + (left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func - (left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func * (left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x * right.x, y: left.y * right.y)
    }
    
    static func * (left: Vector, right: Scalar) -> Vector {
        return Vector(x: left.x * right, y: left.y * right)
    }
    
    static func *= (left: inout Vector, right: Vector) {
        left.x = left.x * right.x
        left.y =  left.y * right.y
    }
    
    static func / (left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x / right.x, y: left.y / right.y)
    }
    
    static func /(lhs: Vector, rhs: Scalar) -> Vector {
        return Vector(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    var length: Scalar {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> Vector {
        return self / length
    }
    
    var angle: Scalar {
        return atan2(y, x)
    }
}
