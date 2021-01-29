//
//  CWDString.swift
//  swfit-1
//
//  Created by 柴伟东 on 2021/1/21.
//

import UIKit

class CWDString: NSObject {
    class func show(){
        t1()
        
    }
    class func t1() {
        //空串
//        let empty = ""
//        let alsoEmpty = String()
       
        
        let validUTF8: [CChar] = [67, 97, 102, -61, -87, 0]
        validUTF8.withUnsafeBufferPointer { ptr in
            let s = String(cString: ptr.baseAddress!)
            print(s)
        }
        // Prints "Café"
   
        let invalidUTF8: [CChar] = [67, 97, 102, -61, 0]
        invalidUTF8.withUnsafeBufferPointer { ptr in
            let s = String(cString: ptr.baseAddress!)
            print(s)
        }
       // Prints "Caf�"
        
        
        
        let validUTF81: [UInt8] = [67, 97, 102, 195, 169, 0]
        validUTF81.withUnsafeBufferPointer{ p in
            let s = String.decodeCString(p.baseAddress,
                                         as: UTF8.self ,
                                         repairingInvalidCodeUnits: true)
            print(s)
        }
     
       // Prints "Optional((Café, false))"
            
        let invalidUTF81: [UInt8] = [67, 97, 102, 195, 0]
        invalidUTF81.withUnsafeBufferPointer { ptr in
                let s = String.decodeCString(ptr.baseAddress,
                                                  as: UTF8.self,
                                                  repairingInvalidCodeUnits: true)
            print(s)
        }
                 // Prints "Optional((Caf�, true))"
    }
    
    
}
