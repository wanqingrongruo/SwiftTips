//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/********** associatedtype *********/

protocol Food {}
protocol Animal {
    
    associatedtype T: Food
    func eat(_ food: T)
}

struct Meat: Food { }
struct Grass: Food { }

struct Tiger: Animal {
    
    //typealias T = Meat
    func eat(_ food: Meat) {
       // if let meat = food as? Meat {
            print("eat\(food)")
//        }
//        else {
//            print("Tiger eat meat only")
//        }
    }
}

struct Sheep: Animal {
    
    func eat(_ food: Grass) {
        print("eat\(food)")
    }
}

let meat = Meat()
let tiger = Tiger()
tiger.eat(meat)

//“在一个协议加入了像是 associatedtype 或者 Self 的约束后，它将只能被用为泛型约束，而不能作为独立类型的占位使用，也失去了动态派发的特性”
/* 这种写法会报错
 func isDangerous(animal: Animal) -> Bool {
 if animal is Tiger {
 return true
 }
 else {
 return false
 }
 }
 */
func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    }
    else {
        return false
    }
}
isDangerous(animal: tiger)


/********** Protocol Extension *********/

protocol MyProtocol {
    
    func myMethod()
}

extension MyProtocol {
    
    // 为协议中的方法提供了默认实现
    // 在具体遵从协议的类型中可以对默认实现进行覆盖
    func myMethod() {
        print("I am MyProtocol' extension.")
    }
    
    // 未在协议中注册...导致遵循协议的类型并不一定实现它, 所以不会动态派发它
    func myMethod2() {
        print("I am MyProtocol' extension.")
    }
}

struct xixixi: MyProtocol {
    // space
}
xixixi().myMethod()

struct hehehe: MyProtocol {
    
    // 重新实现协议中的方法 -> 覆盖默认实现
    func myMethod() {
        print("I am hehehe.")
    }
    func myMethod2() {
        print("I am hehehe.")
    }
    
    func method2() {
        print("I am \(#function)")
    }
}

let h1 = hehehe()
h1.myMethod() // I am hehehe.
h1.myMethod2() // I am hehehe.
h1.method2() // I am method2()


/* 深入探讨一下
 * 联想一下, swift 中 protocol 是 table dispatch , 但是 protocol 的 extension 是 direct dispatch
 * myMethod2() 没有在 MyProtocol 中注册, 而是在 MyProtocol 的 extension 中实现的, 所以 myMethod2() 是直接派发的
 * 这里就能很好解释了下面的输出结果
 * 当 h2 被转化成 MyProtocol, myMethod2() 未被注册, 所以是 direct dispatch, 即使原来 h1 中重新实现了myMethod2(), 但对于MyProtocol协议,他只能找到其 extension 中的实现
 */
let h2 = h1 as MyProtocol
h2.myMethod()  // I am hehehe.
h2.myMethod2() // I am MyProtocol' extension.




