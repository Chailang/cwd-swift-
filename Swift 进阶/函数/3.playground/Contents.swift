import UIKit

var str = "Hello, playground"
/*
 6.2 局部函数和变量捕获
 */

func chooseStepFunction(backwards: Bool) -> (Int) -> Int{
    func stepForward(input: Int) -> Int {return input + 1}
    func setpBackward(input: Int) -> Int { return input - 1 }
    return backwards ? setpBackward : stepForward
}
var currentValue = -4

// moveNearerToZero 是chooseStepFunction的返回值，实质是一个参数是Int 返回值是Int函数。
let moveToZero = chooseStepFunction(backwards: currentValue > 0)
while currentValue < 0 {
//    print("current = \(currentValue)..")
    // 调用函数，获得返回值
    currentValue = moveToZero(currentValue)
}


/*
 
 总共走20步
 前 10 步前进
 后 10 步倒退
 */
var nowStep = -9 //
var steps = 0 //走多少步
while steps < 20  {
    let stepFunc = chooseStepFunction(backwards: steps > 10)
    nowStep = stepFunc(nowStep)
    print("nowStep = \(nowStep)")
    steps += 1
}
