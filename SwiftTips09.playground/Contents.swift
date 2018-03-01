//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## static and class

// 类型范围作用域
// static: 非 class 类型,声明存储属性/计算属性/方法
// class: 修饰类方法和类的计算属性,不能修饰存储属性
// 类中的类的存储属性可以使用 static  修饰

class OverClass {
    static var teacher: String?
    
}

// Protocol 中的类型域上的方法或计算属性,在使用的时候，struct 或 enum 中仍然使用 static，而在 class 里我们既可以使用 class 关键字，也可以用 static”
protocol MyProtocol {
    static func myFunc()  // 定义时使用 static
}

struct MyS: MyProtocol {
    static func myFunc() {
        //
    }
}

class MyC: MyProtocol {
    class func myFunc() {  // 也可以使用 static
        //
    }
}
