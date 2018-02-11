//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//: ## 方法嵌套

//: ## 命名空间

// swift 的 namespace 是基于 module 的,而不是在代码中显示的指明. 每个 module 代表了 swift 中一个 namespace
// 我们可以通过 创建 target -> cocoa touch framework 来创建一个 module
// 同样, 可以使用类型嵌套的方式来指定访问的范围. eg. 将方法放在 struct 中

//: ## 可变函数参数
/*:
 * ## 限制
 * 同一个方法中只有一个参数是可变的
 * 可变参数的类型必须是一样的
 */

func moreArgs(numbers: Int...) {
    numbers.forEach{ print($0) }
}

moreArgs(numbers: 1, 2, 3)
moreArgs(numbers: 6)

//: ## 初始化方法的顺序

// 自己的属性 => super.init() => 父类属性的重新赋值


//: ## Designated, Convenience, Required
// 目的: 安全

// Designated: 指定构造器, 初始化当前类型所有非 optional 类型的属性(可以对常量赋值,线程安全)
/*:
 * ## Convenience
 * 必须调用同一个类中的 Desginated 方法
 * 不能被子类重写或者从子类中以 super 的形式调用
 * 只要在子类中重写了父类的 convenience 方法需要的 designated 方法,在子类中就可以使用父类的 convenience 方法
 */

class A {
    let num: Int
    required init(num: Int) {
        self.num = num
    }
    
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 1_000_000 : 1)
    }
}

class B: A{
    let numB: Int
    
    required init(num: Int) {
        self.numB = num + 1
        super.init(num: um)
    }
}

let b = B(bigNum: true)
b.numB

/*:
 * ## Required
 * 强制子类一定重写实现这个 designated 方法
 * 好处: 依赖某个 designated 的 convenience 方法一直可以被使用
 * required 也可以用来限制 convenience 方法, 要求必须重写父类的某个 convenience 方法,而不是直接使用
 */



//: ## 初始化返回 nil

// init?(), 在这种方法内可以飞 self 赋值



















