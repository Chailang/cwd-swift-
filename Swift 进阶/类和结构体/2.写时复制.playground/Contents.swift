import UIKit


var x = [1,2,4]
var y = x
x.append(5) //1,2,4,5
y.removeLast() //1,2
y
/*
 这时，把x赋值给y时会发生复制。这时候两个数组的引用指向的是内存中的同一个位置。共享存储部分。 当改变x时这个共享会被检查到。 内存将会被复制出来。 我们就独立的改变了两个变量。 耗性能的元素复制操作只会在必要的时候发送。这个就叫做写时复制。

 ####通俗来说： 复制时用的是一个内存地址，当某一个集合改变时恰到好处的复制了一份出来。

 已经用官方，非官方，简洁的语句解释了三遍了朋友我相信你肯定懂的！
 */




/*
 写时复制的高效方法
 1首先要知道一个对象是否是唯一引用的,通过系统提供的isKnownUniquelyReferenced(&obj)函数来获取。
 */
final class Box<A> {
    var unbox:A
    init(_ value:A) {
        self.unbox = value
    }
}
var a = Box(NSMutableData())
isKnownUniquelyReferenced(&a)
var b = a
isKnownUniquelyReferenced(&a)
isKnownUniquelyReferenced(&b)


/*
然后判断为false时执行写是复制(这里详读了一遍感觉比较艰深晦涩，大家可在参考下面的Demo理解)。
 */
struct MyData{
    fileprivate var _data: Box<NSMutableData>
    var _dataForWriting: NSMutableData{
        mutating get{
            //检查对_data的引用是否是唯一性
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("Making a copy")
            }
            return _data.unbox
        }
    }
    init(_ data:NSData) {
        self._data = Box(data.mutableCopy() as! NSMutableData)
    }
    
}
extension MyData{
    mutating func append(_ other:MyData) {
        _dataForWriting.append(other._data.unbox as Data)
    }
}

let someBytes = MyData(NSData(base64Encoded: "wAEP/w==", options: [])!)
var empty  = MyData(NSData())
var emptyCopy = empty
for _ in  0..<10 {
    empty.append(someBytes)
}
empty
emptyCopy

