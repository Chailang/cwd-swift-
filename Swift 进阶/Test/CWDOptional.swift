//
//  CWDOptional.swift
//  swfit-1
//
//  Created by 柴伟东 on 2021/1/25.
//

import UIKit

class CWDOptional: NSObject {
    var voidCallback:(()-> Void)?
}


extension CWDOptional{
    
    class func show(){
        test5()
    }
    
    class func test1(){
        ///返回值为Optional的实质
        let strArray = ["one","two","three"]
        switch strArray.firstIndex(of: "four") {
           case .none:
               print("返回值为空") //返回值为空
           case .some(let idx):
               print(idx)
               print("有值")
           }
    }
//    if let
//
//    相信大家在swift 入门的时候就已经能很好的使用这个语法了。 不赘述。
//
//
    class func test2(){
        let a:String? = "a"
        // 技巧1： 可与Bool 联合判断
        if let _ = a,2 > 1 {
            print("条件都成立")
        }else{
            print("有条件出错")
        }
        
        
       // 技巧2： 多let 并列
        var c ,d , e, g : String?
        c = "c"
        d = "d"
        e = "e"
        if let _ = c , let _ = d , let _ = e {
            print("1条件都成立")
        }else{
            print("2有条件出错")
        }
      
        
        var array = ["one","two","three","four"]
        if let idx = array.lastIndex(of: "four") {
            array.remove(at: idx)
        }
        print("array =\(array)")
        
        //while let
       // 类似于if let 遇到nil时终止循环 也有和上面👆技巧1（一旦为false 就循环停止，并不是filter那样去工作）相同的使用方法。不赘述。
        //它表示一个当遇到nil时终止循环
        /*协议提供makeIterator方法创建迭代器，
            而迭代器中的nex方法将不断返回序列中的值，
            当序列中的值耗尽时,nil 将被返回值，所以
            我们用 while let 终止循环*/
        let array1 = [g,e,d,c]
        var itearator = array1.makeIterator()
        while let i = itearator.next() {
            print(i)
        }
        
        
       // if var 和 while var

       //  和 let 的使用类似。 但你var 出来的obj实际上是一个本地副本 你对obj做任何更改都不会影响原来的值。
        let dict:[String:String]?
        dict = ["key1":"value1"]
        if var varDict = dict {
            varDict["key1"] = "value2"
            print(varDict)
        }
        print(dict) //Optional(["key1": "value1"])
        
    }
    
    class func test3(){
       // 可选链
        //✅ 推荐
        //voidCallvack?()
        let a = CWDOptional()
        a.voidCallback?()
        a.voidCallback = {
            print("voidCallback")
        }
        a.voidCallback?()
    }

    class func test4(){
        let a = 100.half?.half?.half?.half
        print("4 次half = \(a ?? 0)")
        
        
      //  nil合并运算符 ??
        var number: Int?
        number = nil
        let numStr =  number ?? 5
        print(String(numStr))
    }
    
    class func test5(){
        // 可选值map
        /*
         可选值flatMap(Demo值得借鉴)
         flatMap 是一个很有趣的函数
         flat的意思是“扁平的”，有一个主要作用就是降维。可以把多维数组降低维数。 下面的demo主要介绍flatMap的转换功能
         */
        ///将一个网络图片加载出来的奇淫方法！！！
        let urlString = "http://www.objc.io/logo.png"
        let view = URL(string: urlString)
            .flatMap { (url) -> Data? in
                try? Data(contentsOf: url)
            }
            .flatMap { (data) -> UIImage? in
                UIImage(data: data)
            }
            .map { (image) -> UIImageView in
                UIImageView(image: image)
            }
        
        if let view = view {
            UIView().addSubview(view)
        }
        
        
        //利用swift中的$0语法简化上面的代码
        let view2 = URL(string: urlString)
            .flatMap {
                try? Data(contentsOf: $0)
            }
            .flatMap {
                 UIImage(data: $0)
            }
            .map {
                 UIImageView(image: $0)
            }
        if let aview2 = view2 {
            UIView().addSubview(aview2)
        }
    }
}
//多个可选链的调用。下面这个例子简单易懂，不赘述。
extension Int {
    var half: Int? {
        guard self > 1 else {return nil}
        return self/2
    }
    
}
