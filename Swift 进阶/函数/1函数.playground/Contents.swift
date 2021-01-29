import UIKit

/*
 首先我们要先知道函数的三个知识点
 函数可以赋值给变量，也可以作为另外一个函数的参数和返回值
 */

func loveSomeBody(name:String) {
        print("I love \(name)")
}

loveSomeBody(name: "冰冰")

//变量
var loveSomeBobyFunc:((String)->Void)?

///函数赋值给变量
loveSomeBobyFunc = loveSomeBody
loveSomeBobyFunc?("居然没爱的人")


//函数作为参数
func doSomeThing(things: ((String)->Void)?){
    things?("干点事情")
}
doSomeThing(things: loveSomeBobyFunc)


///函数作为返回值
func loveingYou() -> ((String) ->Void)? {
    return loveSomeBody
}
loveingYou()?("鬼")
loveSomeBobyFunc = loveingYou()
loveSomeBobyFunc?("哈哈")

//函数可以捕获其局部作用域之前的变量（同OC,不赘述）。
//除了func创建函数 {}也可以创建函数，这个叫闭包表达式
var a = {print("我是闭包函数")}
a()

/*
 这里延伸一下，我们平时在写懒加载的时候用法如下, {} 就是一个方法，()表示执行这个方法。 和平时调用方法func() 使用是类似的。
 */
var label: UILabel = { () -> UILabel in
    return UILabel()
}()

let view = { return UIView() }()
print(view)
///常见的map用法，里面就用到了{}
///$0的含义后面再讲，相信大部分同学都了它的意思。 一句话概况就是[闭包里面的默认值]。
let temp = [1,2,3,4].map{$0 * 2}
print(temp)
