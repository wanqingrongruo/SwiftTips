//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## AnyClass, 元类型和 .self
// 元类型编程

typealias AnyClass = AnyObject.Type

class A {
    
}

// A.Type 代表的是 A 这个类型的类型(元类型, meta)
// .self 可以在类型后面取得类型本身, 也可以在某个实例后面取得这个实例的本身
let typeA: A.Type = A.self


//: ## 协议和类方法中的 Self
protocol  Copyable {
    
    // 1. 协议没有上下文,我们并不知道最后究竟是什么样的类型来实现了这个协议
    // 2. swift 中也不能在协议中定义泛型进行限制
    // So 我们用 Self 来指代 实现了协议本身的类型
    // Self 不仅指代的是实现该协议的类型本身,也包括了这个类型的子类
    func copy() -> Self
}

class MyClass: Copyable {
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init()
        result.num = num
        return result
    }
    
    required init() { // swift 必须保证当前类及其子类都能响应这个 init 方法
        
    }
}

let object = MyClass()
object.num = 100

let newObject = object.copy()
object.num = 1

print(object.num)
print(newObject.num)

//: ## 动态类型和多方法

class Pet { }
class Cat: Pet { }
class Dog: Pet { }

func printPet(_ pet: Pet) {
    print("Pet")
}
func printPet(_ cat: Cat) {
    print("Cat")
}
func printPet(_ dig: Dog) {
    print("Dog")
}

print(Pet())
print(Cat())
print(Dog())


func printThem(_ pet: Pet, cat: Cat) {
    printPet(pet)
    printPet(cat)
}

// 不会因运行时改变... Swift 默认情况下不采用动态派发
printThem(Dog(), cat: Cat())
















