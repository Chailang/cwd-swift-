//
//  FIFOQueue.swift
//  swfit-1
//
//  Created by 柴伟东 on 2021/1/23.
//

import Foundation
//自定义一个FIFO(First Input First Output)的集合去了解一些细节

//队列的实现
//自己写一个最简单的将元素入队和出队的类型
protocol Queue {
    // self中所持有的元素类型
    associatedtype Element
    // 把newElement 加入队列
    mutating func enqueue(_ newElement:Element)
    // 从self出队一个元素
    // 返回值是可选值? 队列为空时这样的做法是安全的
    mutating func dequeue() ->Element?
}
//下面我们将准守上面的Queue协议，写一个FIFO( First Input First Output)队列
struct FIFOQueue:Queue {
    typealias Element = Int
    fileprivate var left: [Int] = []
    fileprivate var right: [Int] = []
    ///把元素添加到队尾
    /// 复杂度O(1)
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    /// 从队列首部移除一个元素
    /// 队列为nil时候返回空
    /// - 复杂度： 平摊 O(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
     func show()  {
        dropFirst()
    }
    func queuetest(){
        var q  = FIFOQueue()
        for i in  0 ..< 10 {
            q.enqueue(i)
        }
        let e = q.dequeue()
        print(e)
        let f = q.index(after: 1)
        print(f)
    }
    func dropFirst(){
        ///下面的操作实际等于 [1,2,3,4,5].dropFirst()
           let list = [1,2,3,4,5]
           let onePastStart = list.index(after: list.startIndex)
           let firstDropped = list[onePastStart..<list.endIndex]
           let  a =  Array(firstDropped) //[2,3,4,5]
           print("自己处理去掉第一个元素",a)
           let b = [1,2,3,4,5].dropFirst()
            print("系统处理去掉第一个元素",b)
           let mA = MemoryLayout.size(ofValue: [1,2,3,4,5]) //8
           let mB = MemoryLayout.size(ofValue: [1,2,3,4,5].dropFirst()) //32
           print("内存ma=\(mA) mb =\(mB),")
    }
}

//下面可以为它添加Collection协议啦
extension FIFOQueue: Collection{
    public var startIndex: Int {return 0}
    public var endIndex: Int { return left.count + right.count }
    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    public subscript(position: Int) -> Int {
        precondition((0..<endIndex).contains(position), "index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        }else {
            return right[position - left.count]
        }
    }
}
//遵守 ExpressibleByArrayLiteral协议

//ExpressibleByArrayLiteral的主要作用是可以让对象支持字面量初始化 那什么是字面量？ (不太知道的同学可以大概瞜一眼菜鸟教程里的解释) 字面量其实就是让你的集合可以用类似[value1, value2, etc]的方式去创建。
extension FIFOQueue: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Int
    init(arrayLiteral elements: Int...) {
        self.init(left: elements.reversed(), right: [])
    }
}
