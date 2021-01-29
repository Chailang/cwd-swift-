import UIKit

var str = "Hello, playground"

struct Point {
    var x:Int
    var y:Int
    /*
     操作符重载
     将两个结构体相加，可以对+操作符进行重载
     */

    static func +(aPoint: Point, bPoint: Point) ->Point{
        return Point(x: aPoint.x + bPoint.x, y: aPoint.y + bPoint.y)
    }
}

//tips: 如若有一个经常使用的结构体值，可以以静态属性定义在扩展内，如下

extension Point{
    static let origin = Point(x: 0, y: 0)
    //属于结构体的
    static var age = 10
}
//结构体中还能包含其他结构体属性


/*
 知识点4:struct中如果需要改变self，或者需要改变self中任何属性。 则需要使用mutating 关键字
mutating 关键字的作用就是标记self是可以改变的
 知识点5：swift会自动将属性的setter标记为mutating
 知识点6：很多情况下 一个方法会有可变和不可变的区分 如数组的 sort() 是可变方法 sorted() 不可变方法会返回一个新的数组。 swift中还有很多类似的方法。（感觉这里可以出一个很好的面试题，说说两个方法的区别。）
 */
extension Point{
    mutating func transLateY(by offset:Int){
        y = y + offset
    }
}



//在swift5.1以后如果结构体的常量有默认值。 系统会提供有默认值属性和没有默认值属性的两种初始化方法
struct People{
    var name:String
    var age :String
    var school:String = "清华大学" //默认值
}

//1.swift会自动会结构体的成员变量添加初始化方
func test(){
    var point = Point(x: 1, y: 1)
    print(point)
    point.y = 10
    print(point)
    point.transLateY(by: 2)
    print(point)
    
    //static 修饰的变量可变
    Point.age = 20
    
    //结构体的属性
    print(Point.origin)
    print(Point.age)
    

    
    /*
    知识点2：
    结构体的一个属性被赋值时, 它的didSet方法会被调用
    被调用的原因:
    结构体的某个深层次的属性被改变时，等于是改变了结构体，重新为它赋值。
     所以 didSet会被调用。
    知识点3：在swift中 Array是结构体 当改变数组中某个元素的属性时 数组的didSet也会被调用.
     */
    var xPoint = Point(x: 10, y: 10){
        didSet{
            print("哇哦~我被调用了")
        }
    }
    xPoint.x = 10
    
    
    //2个点相加
    let newP = point + point
    print(newP)
    
    
    
    
    let people1 = People(name: "cwd", age: "30")
    print(people1)
    let people2 = People(name: "lbr", age: "29", school: "北大")
    print(people2)
    
    var f = 5
    triple(x: &f)
    print(f)
}

/*
 
 了解mutating关键字
 了解mutating关键字要先了解inout行为。
 */

//func triple(x:Int){
//    x = x * 3 //error x is let
//}
///inout 关键字可以将原来的值覆盖
func triple( x:inout Int) {
    x = x * 3 // ojb
}
test()
