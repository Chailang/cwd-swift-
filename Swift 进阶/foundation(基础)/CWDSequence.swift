//
//  CWDSequence.swift
//  swfit-1
//
//  Created by 柴伟东 on 2021/1/21.
//

import UIKit

//swift 进阶

//集合类型协议
class CWDSequence: NSObject {
    
    class func show() {
//        runMyfirstSquence()
    }
    
    
}
//1.自定义sequence
//第一步: 创建一个迭代器(Iterator)
struct PrefixStrIterator:IteratorProtocol {
    var string: String
    var offset: String.Index
    init(string:String) {
        self.string = string
        offset = string.startIndex
    }
    ///写协议方法
    mutating func next() -> String? {
        guard offset < string.endIndex else { return nil}
        offset = string.index(after: offset)
        return String(string[string.startIndex..<offset])
    }
}

//第二步: 创建一个使用这个迭代器的序列(sequence)

struct PrefixSequence: Sequence {
    var string: String
    ///协议方法：返回一个迭代器
    func makeIterator() -> PrefixStrIterator {
        return PrefixStrIterator(string: string)
    }
}


//第三步: run~  写在下面 runMyfirstSquence




//2.基于函数的迭代器和序列
/// 通过引用语义的特性写斐波那契
func fibsIterator() -> AnyIterator<Any>{
    var startNum = (0,1)
    return  AnyIterator{
        let nextNum = startNum.0
        startNum = (startNum.1,startNum.0 + startNum.1)
        return nextNum
    }
}


extension CWDSequence {
 
    
    class func arraySequence(){
        let numbers = [2, 3, 5, 7]
        var numbersIterator = numbers.makeIterator()
        while let num = numbersIterator.next() {
             print(num)
        }
    }
    
    class func runMyfirstSquence(){
        for prefixStr in PrefixSequence(string: "Hi~LiaoWorking!"){
            print(prefixStr)
        }
    }
}


