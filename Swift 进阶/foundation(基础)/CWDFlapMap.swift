//
//  CWDFlapMap.swift
//  Swift 进阶
//
//  Created by 柴伟东 on 2021/1/27.
//

import UIKit

class CWDFlapMap: NSObject {
    
    class func show() {
        let instance = CWDFlapMap()
        instance.test5()
    }
    func t1(){
        let numbers = ["1","2","3","4","liaoworking"]
        ///普通青年
        var sum = 0
        for case let i? in numbers.map({
            Int($0)
        }) {
            sum += i// Int($0)为nil就不走这里了
        }
        //
        print("普通 sum = \(sum)")
        
        let temp = numbers.map {Int($0)}
        print("temp =>\(temp)")
        
        ///优质青年
        ///当我们用?? 把nil替换成0
        sum = numbers.map { Int($0) }.reduce(0) { $0 + ($1 ?? 0)} //10
        print("优质青年 sum = \(sum)")
        
        ///文艺青年
        ///在标准库中flatMap的作用可能正是你想要
        sum = numbers.compactMap { Int($0) }.reduce(0, +) // 10
        print("文艺 sum = \(sum)")
        
        
    }
    
    // switch case 匹配可选值
    func test2(){
        let numbers = ["1","2","3","4","liaoworking"]
        for i in numbers {
            switch Int(i) {
            case 0:
                print("0")
            case nil:
                print("can't convert to int")
            default:
                print("not in case")
            }
        }
        
        ///在一个温度数组中
        let temp = ["-23", "0", "66.66", "warm"]
        
        // Double("warm") 的值为nil
        
        // Double("warm") < 0 是成立的
        
        //但你不能说warm是小于0度的是很冷的。
        let nt = temp.map { Double($0) }
        print(nt)
        
    }
    
    func test3(){
        
        
        // numbers.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result#>)
        // 初始值， 遍历 numbes 对初始值累加
        
        
        //30 为初始值，累加
        let numbers = [1, 2, 3, 4]
        
        let numberSum = numbers.reduce(30, { x, y in
            x + y
        })
        print(numberSum)
        
        
        
        //letterCount = letters.reduce(into: <#T##Result#>, <#T##updateAccumulatingResult: (inout Result, Character) throws -> ()##(inout Result, Character) throws -> ()#>)
        // info 需要构造的字典, 更新字典
        let letters = "abracadabra"
        let letterCount = letters.reduce(into: [:]) { counts, letter in
            counts[letter, default: 0] += 1
        }
        let letterCountDic = letters.reduce(into: [:]) { (dic, letter) in
            dic[letter, default: 0] += 1
        }
        print("letterCount => \(letterCount)")
        print("letterCountDic => \(letterCountDic)")
        
        ///     // letterCount == ["a": 5, "b": 2, "r": 2, "c": 1, "d": 1]
        
        
        
    }
    func test4(){
        let numbers = [1, 2, 3, 4]
        let mapped = numbers.map { Array(repeating: $0, count: $0) }
        print("mapped = \(mapped)")
        ///     // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
        ///
        let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
        print("flatMapped = \(flatMapped)")
        ///     // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
        
        
        let possibleNumbers = ["1", "2", "three", "///4///", "5"]
        ///
        // map 会产生nil
        let  numsMapped: [Int?] = possibleNumbers.map { str in Int(str) }
        ///     // [1, 2, nil, nil, 5]
        print("numsMapped \(numsMapped)")
        ///compactMap 会移除nil
        let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
        ///     // [1, 2, 5]
        print("compactMapped \(compactMapped)")
        
        
    }
    
    func test5(){
        //4.4强制解包(使用!)的时机
        /*
         对于使用！有以下几种观点
         
         绝不使用
         
         使代码逻辑更清晰的时候使用
         
         不可避免的时候使用
         */
        let ages = ["wangzhuxian":26, "liaoWorking":37, "angel": 16]
        /// 有强制解包   这里的强制解包绝对安全
        var  temp = ages.keys.filter { name in ages[name]! < 30 }.sorted()
        print("temp = ",temp)
        
        ///巧妙的避开了强制解包  写的时候心里也踏实哈哈
        temp = ages.filter { (_, age) in age < 30 }
            .map { (name, _) in name }
            .sorted()
        print("temp = ",temp)
    }
    
}
