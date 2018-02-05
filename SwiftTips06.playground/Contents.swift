//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## Currying 柯里化

/*:
 * ##
 * 函数式编程的重要表现
 * 批量生产方法
 */


// 1.
func addTo(num: Int) -> (Int) -> Int {
    return { n in
            return n + num
    }
}
let addFunc = addTo(num: 3)
let result = addFunc(4)

// 2.
func greaterThan(comparer: Int) -> (Int) -> Bool {
    return { $0 > comparer }
}
let greaterThan10 = greaterThan(comparer: 10)
greaterThan10(12)
greaterThan10(9)

// 3. target - action 改造
protocol TargetAction {
    func performAction()
}
struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}
enum ControlEvent {
    case TouchUpInside
    case ValueChanged
    // ...
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T, action: @escaping (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}


//: ## 将 protocol 的方法声明为 mutating

// mutating 修饰方法是为了能在该方法中修改 struct/enum 的属性变量
// mutating 对 class 是完全透明的. class 可以随意修改自己的属性
protocol Vechicle {
    var numberOfWheels: Int { get }
    var color: UIColor { get set }
    
    mutating func changeColor()
}

struct MyCar: Vechicle {
    let numberOfWheels: Int = 4
    var color: UIColor = .blue
    
    mutating func changeColor() {
        color = .red
    }
}

//: ## Sequence
// 遵循 IteractorProtocol

// 反向的迭代器
class ReverseIteracotr<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    // 迭代器必须知道 1.序列中元素的类型 2. 获取下个元素的 next() 方法
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        }
        else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    // 指定迭代器类型
    typealias Iterator = ReverseIteracotr<T>
    
    // 迭代
    func makeIterator() -> ReverseIteracotr<T> {
        return ReverseIteracotr(array: self.array)
    }
}


let arr = [0, 1, 2, 3, 4]
for (index, value) in ReverseSequence(array: arr).enumerated() {
    print("Index \(index) is \(value)")
}

// for...in 的原理
var ite = arr.makeIterator()
while let value = ite.next() {
    print(value)
}

// ReverseSequence 的意外收益是 map/filter 等语法糖
// Sequence 协议的 extension 中提供了默认实现
let reverseString = ReverseSequence(array: arr).map { (item) -> String in
    return String(describing: item)
}

//: ## Tuple

// 1. 不使用额外空间进行交换
func swap<T>(a: inout T, b: inout T) {
    (a, b) = (b, a)
}
var a = 3
var b = 44
swap(&a, &b)
a
b

// 2. 多返回值 -- 相较于 oc 单一返回只能返回指针要好用的多
let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
let (small, large) = rect.divided(atDistance: 20, from: .minXEdge)
small
large

//: ## @autoclosure and ??
// @autoclosure: 把一句表达式自动封装成一个闭包

func logIfTrue(predicate: () -> Bool) {
    if predicate() {
        print("True")
    }
}

logIfTrue { 2 > 1 }

func logIfTrue2(predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}
logIfTrue2(predicate: 2 > 1)
// 2 > 1 被自动转换为 () -> Bool

// ?? 操作符的实现就是使用了 @autoclosure

var level: Int?
var start = 1

var currentLevel = level ?? start
// 这里 start 会自动转换为 () -> Int -- 在 ?? 真正取值之前并没有确定 start 的具体值, 这对于 start 需要进行复杂计算才能得到的情况来说不至于造成资源浪费. 这样的开销完全是可以避免的, 方法就是讲默认值的计算推迟到 optional 判定为 nil 之后

// 注意:
// @autoclosure 不支持带有入参的 写法
// 避免歧义. 注意使用时机

infix operator |||  // 或
func |||(lhs: Bool, rhs: @autoclosure () -> Bool) -> Bool {
    if lhs {
        return true
    }
    else if rhs() {
        return true
    }
    return false
}


let isTrue = (2 > 1) ||| (3 > 4)







