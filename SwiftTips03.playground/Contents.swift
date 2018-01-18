//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## 属性观察 Property Observers

class MyClass {
    let oneYearInSecond: TimeInterval = 365 * 24 * 60 * 60
    var date: NSDate {
        willSet {
            let d = date
            print("即将将日期从\(d) 设定至 \(newValue)")
        }
        
        didSet {
            
            if date.timeIntervalSinceNow > oneYearInSecond {
                print("设置的时间太晚了")
                date = NSDate().addingTimeInterval(oneYearInSecond)
            }
            print("已经将日期从\(oldValue)设定至\(date)")
        }
    }
    
    init() {
        date = NSDate()
    }
}

let foo = MyClass()
foo.date = foo.date.addingTimeInterval(100_000_000)

// 初始化方法对属性的设定,以及在 `willSet` 和 `didSet` 中对属性的再次设定都不会再次出发属性观察的调用


class A {
    var number: Int {
        get {
            print("get")
            return 1
        }
        set {
            print("set")
        }
    }
}

class B: A {
    override var number: Int {
        willSet {
            print("wiilSet")
        }
        didSet {
            
            // 可能调用 oldValue ... 所以 `get`方法会在 `set` 方法调用前调用,以保证值得正确性.
            print("didSet")
        }
    }
}
// 在同一个类型中,属性观察和计算属性是不同同时共存的
// 重写的属性并不知道父类属性的具体情况,而只从父类属性中继承名字和类型. 因此在子类中的重载属性中我们是可以对父类的属性任意添加属性观察的

let b = B()
b.number = 0


//: ## final

// 表示不允许对该内容进行继承或者重写操作,用在 class, func, var 前面进行修饰.
/*:
 * ## 事情情况
 * 类或者方法的功能确实已经完备了
 * 子类继承和修改是一件危险的事情
 * 为了父类中的某些代码一定会被执行
 * 性能考虑
 */

class Parent {
    final func method() {
        print("开始配置")
        
        methodImpl()
        
        print("结束配置")
    }
    
    func methodImpl() {
        fatalError("子类必须实现这个方法")
    }
}

class child: Parent {
    override func methodImpl() {
        //
    }
}


//: ## lazy 修饰符和 lazy 方法


class ClassA {
    lazy var str: String = {
        let str = "Hello"
        return str
    }()
    
    lazy var simpleStr: String = "Hi"
}

// Swift 标准卡中的 lazy 方法
/*
 * func lazy<S : SequenceType>(s: S) -> LazySequence<S>
 
 * func lazy<S : CollectionType where S.Index : RandomAccessIndexType>(s: S)
 -> LazyRandomAccessCollection<S>
 
 * func lazy<S : CollectionType where S.Index : BidirectionalIndexType>(s: S)
 -> LazyBidirectionalCollection<S>
 
 * func lazy<S : CollectionType where S.Index : ForwardIndexType>(s: S)
 -> LazyForwardCollection<S>
 */

// 配合 map/filter 等这类接受闭包并进行运行的方法一起,让整个行为变成延时进行
// 对于那些不需要完全运行,可能提前退出的情况使用 lazy 来进行性能优化效果非常明显
let data = 1...3
let result = data.lazy.map { (i: Int) -> Int in
    print("正在处理\(i)")
    return i*2
}
print("准备访问结果")
for i in result {
    print("操作后的结果为\(i)")
}
print("操作完毕")


//: ## Reflection 和 Mirror
struct Person {
    let name: String
    let age: Int
}

let xiaoming = Person(name: "xiaoming", age: 25)
let r = Mirror(reflecting: xiaoming)
type(of: r)
print("xiaoming 是 \(String(describing: r.displayStyle))")
print("属性个数: \(r.children.count)")
for child in r.children {
    print("属性名: \(String(describing: child.label)), 值: \(child.value))")
}

// dump: 获取一个对象的镜像并进行标准格式的输出
dump(xiaoming)


func valueFrom(_ object: Any, key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    
    for child in mirror.children {
        let (targetKey, targetValue) = (child.label, child.value)
        
        if key == targetKey {
            return targetValue
        }
    }
    
    return nil
}

if let name = valueFrom(xiaoming, key: "name") as? String {
    print("通过 key 得到值: \(name)")
}












