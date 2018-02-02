//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: ## Selector

class myClass {
    
    @objc private func callMeWithParam(obj: AnyObject!) { }
    
    let someMehtod = #selector(callMeWithParam(obj:))
}

//: ## 实例方法的动态调用

class MyDynamic {
    
    func method(number: Int) -> Int {
        return number + 1
    }
    
    class func method(number: Int) -> Int {
        return number
    }
}

let obj = MyDynamic()
let result = obj.method(number: 22)

// 直接用 Type.instanceMethod 直接生成一个可以柯里化的方法
// 遇到与类型方法的名字冲突时,显式的加上类型声明加以区别
let df: (MyDynamic) -> (Int) -> Int = MyDynamic.method
let res = df(obj)(23)

// df 等价于
let f = { (obj: MyDynamic) in
    return obj.method
}

//: ## 单例 singleton

class MySingleton {
    static let shared = MySingleton()
    
    // 其他地方不再能初始化
    // 可以去掉 这个私有的初始化方法, 如果这个类的使用者想要自己创建实例
    private init() { }
}


//: ## 条件编译

/*
 #if <condition>
 
 #elseif <condition>
 
 #else
 
 #endif
 */
// 大小写敏感

// 对自定义符号进行条件编译

//func someButtonPressed() {
//
//    #if FREE_VERSION => 编译符号
//    //
//    #else
//    //
//    #endif
//}

/*
 编译符号:在项目的 Build Settings 中，找到 Swift Compiler - Custom Flags，并在其中的 Other Swift Flags 加上 -D FREE_VERSION 就可以了
 */


//: ## @UIApplicationMain

/*
 * oc 项目 main.m 文件
int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMian(argc, argv, nil, NSStringFromClass([AppDelegate class]))
    }
}
 
 * 方法将根据第三个参数初始化一个 UIApplication 或其子类的对象并开始接收事件,传入 nil 意味着使用默认的 UIApplication
 * 最后一个参数 指定了 AppDelegate 类作为应用的委托, 它被用来接收 类似 didFinishLaunching 或者 didEnterBackground 这样的与生命周期相关的委托方法
 * 返回值, 虽然标明是返回 一个 Int, 但是其他并不会真正的返回. 它会一直存在于内存中,直到用户或者系统将其强制终止
 */

/*:
 * ## Swift @UIApplicationMain 标签
 * 作用: 将标注的类作为委托,去创建一个 UIApplication 并启动这个程序
 * <#item2#>
 * <#item3#>
 */

class MyApplication: UIApplication {
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        print("Event sent: \(event)")
    }
}

/* main.swift
 * 替换第三个参数(UIApplication的子类) --- 轻易的做一些控制整个应用行为的事情了
UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(MyApplication), NSStringFromClass(AppDelegate))
 */


//: ## @objc 和 dynamic

//@objc - 让 oc 识别到
//继承自 NSObject 的 class 的 非 private 方法是默认自动加上 @objc 的
//@objc 不改变派发方式

// dynamic == 修改派发方式为 消息派发









