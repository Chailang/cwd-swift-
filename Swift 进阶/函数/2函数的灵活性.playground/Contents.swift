import UIKit
/*
 函数的灵活性
 */
var mArray = [3,1,2]
mArray.sort()
mArray.sort(by: >)

let animal = ["fish", "dog", "elephanta"]
// 反向比较字符串的大小  我们可以嵌套任意的比较函数  让排序功能更强大！
let okAnimal = animal.sorted { (left, right) -> Bool in
    let l = left.reversed()
    let r = right.reversed()
    /// ⭐️核心方法⭐️ 按顺序比较两个字符串的大小   abc > abb 返回值是一个Bool
    return l.lexicographicallyPrecedes(r)
}

print(okAnimal)


//String的lexicographicallyPrecedes方法在项目中挺实用的，是swift标准库自带方法，像比较时间字符串"2018-08-08" 和 "2018-03-04" 的时间先后就可以用这个方法。
let timea = "2018-08-08"
let timeb = "2018-03-04"
let timec = "2018-03-04 12:12"
let timed = "2018-03-04 12:12:36"

let timeArray = [timea,timeb,timec,timed].sorted { (a, b) -> Bool in
    return a.lexicographicallyPrecedes(b)
}

print(timeArray)
//知识点：swift中的排序算法是基于内省算法（introsort），起实质是快排和堆排的混合。 当集合很小时会转化为插入排序。避免不必要的性能消耗。
