//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//: ## @escaping

// 目的: 内存管理
// 告诉使用中 闭包会在当前函数 scope 以外起作用, 小心导致循环引用, 在当前 scope 中谨慎使用 self, weak/unowned
// 起到提醒作用



//: ## Optional chaining

// ?.

class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

let xm = Child()
let toyName = xm.pet?.toy?.name
type(of: toyName)

extension Toy {
    func play() {
        print("play enjoy")
    }
}

let clo = { (child: Child) in
    if let p = child.pet, let t = p.toy {
        t.play()
    }
    else {
        print("\(child) has not a pet or a toy")
    }
}

type(of: clo)

let t = Toy(name: "cc")
let p = Pet()
p.toy = t
xm.pet = p
clo(xm)

let dm = Child()
clo(dm)

//: ## 操作符

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

let v1 = Vector2D(x: 2, y: 3)
let v2 = Vector2D(x: 3, y: 2)

// 重载操作符
func +(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let v3 = v1 + v2

// 定义操作符 -- 不能定义在局部作用域中jjj
// precedencegroup: 定义操作符优先级
precedencegroup DotProductPrecedence {
    associativity: none // 结合律
    higherThan: MultiplicationPrecedence // 运算的优先级
}

// infix: 中位操作符, prefix(前) and postfix(后)
infix operator +*: DotProductPrecedence
func +* (left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}
let v4 = v1 +* v2


//let temArray = [1, 2, 3, 4, 5, 6, 7]
//let a = temArray.suffix(from: 3)
//a.forEach{ print($0) }

//: ## func 的参数修饰

func incrementor(variable: inout Int) {
    variable += 1
}

var i = 10
incrementor(variable: &i)
i

// inout 相当于在函数内部创建了一个新的值,然后在函数返回时将这个值赋值给 & 修饰的变量,这与引用类型的行为是不一样的


//: ## 字面量表达

// 字面量: 能够直截了当的指出自己的类型并为变量进行赋值的值

/*:
 * ## 常用字面量协议
 * ExpressibleByArrayLiteral
 * ExpressibleByBooleanLiteral
 * ExpressibleByDictionaryLiteral
 * ExpressibleByFloatLiteral
 * ExpressibleByNilLiteral
 * ExpressibleByIntegerLiteral
 * ExpressibleByStringLiteral
 */


// 当我们需要自己实现一个字面量表达的时候,可以简单的只实现定义的 init 方法就行了,, 当然只是视具体协议而定的

//: ## typealias

// 用来为已经存在的类型重新定义名字,通过命名,可以诗代码变得更加清晰


// associatedType => 定义类型的占位符, 让实现协议的类型来指定具体的类型
// associatedType 声明中可以使用冒号来指定类型满足某个协议 => associatedType f: Food
// 在添加 associatedType 后, 协议就不能被当做独立的类型使用了 (协议中加了 Self 约束后也不可以被当做独立类型来占位使用) => 只能被用为泛型约束


//: ## 下标

// 一个接受数组作为下标输入的 方法
extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index ou of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index, i) in input.enumerated() {
                 assert(index < self.count, "Index ou of range")
                self[i] = newValue[index]
            }
        }
    }
}

extension Array {
    subscript(input: Int...) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index ou of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index, i) in input.enumerated() {
                assert(index < self.count, "Index ou of range")
//                if i == 3 {
//                   self[i] = 999999 // 冲突
//                }
//                else {
//                   self[i] = newValue[index]
//                }
                self[i] = newValue[index]
            }
        }
    }
}


var arr = [1, 2, 3, 4, 5, 6]
arr[[2,3]] = [10, 11]
arr

arr[2, 3] = [100, 111]
// 当参数列表只有一个输入时与原下标冲突,,,
//arr[3] = 9









