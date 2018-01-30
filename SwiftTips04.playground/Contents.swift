//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## 隐式解包 Optional

var d: Double!
d = 2.333 // 必须初始化, 隐式解包暗示了这个变量不会是 nil,默认自动强制解包
type(of: d)

// 除了 IB, 尽量少用隐式解包


//: ## 多重 Optional

// Optional<Double>  // enum

let s: Optional<String> = "sttt"
type(of: s)
s



var oop: String?? = "sss"
type(of: oop)

var aNil: String? = nil
var anotherNil: String?? = aNil

var literalNil: String?? = nil

if anotherNil != nil {
    print(anotherNil)
}

if literalNil != nil {
    print(literalNil)
}

// fr v - R variable -- 调试命令


//: ## Optional Map

let ms = s.map {
    $0 + "999"
}

//: ## where 和 模式匹配

// 1.
let name = ["ss", "ff", "sf"]
name.forEach {
    switch $0 {
    case let x where x.hasSuffix("s"):
        print(x)
    default:
        print($0)
    }
}

// 2.
let num: [Int?] = [48, 88, nil]
let n = num.flatMap{ $0 }
n
for score in n where score > 60 {
    print("及格啦-\(score)")
}

//let fn: [[Int?]] = [[55, 88], [66,99, nil]]
//let nn = fn.flatMap{ $0 }.flatMap{ $0 }
//nn

// 3. 泛型限制
// 4. 协议扩展限制
// 5. 解包

//: ## indirect 和 嵌套 enum

indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
    
    func removing(_ element: Element) -> LinkedList<Element> {
        guard case let .node(value, next) = self else {
           return .empty
        }
        
        return value == element ? next : LinkedList.node(value, next.removing(element))
    }
}

let linkList = LinkedList.node(1, .node(2, .node(3, .node(4, .empty))))

print(linkList)

let result = linkList.removing(2)
print(result)
