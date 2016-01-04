//
//  MyCustomOperation.swift
//  MultiThreading
//
//  Created by Jigs Sheth on 1/2/16.
//  Copyright © 2016 jigneshsheth.com. All rights reserved.
//

import Foundation


class MyCustomOperation: NSOperation {
  
  var isExecut = false
  var isFinish = false
  
  
  override func main() {
    if self.cancelled {
      return
    }else {
      print("Custom operation work is done here")
      for i in 1...5 {
        print("Custome call times : \(i)")
        sleep(1)
      }
      
      self.willChangeValueForKey("executing")
      isExecut = false
      self.didChangeValueForKey("executing")
      
      
      self.willChangeValueForKey("finished")
      isFinish = true
      self.didChangeValueForKey("finished")
      
      
      if isFinish {
        print("Operation completed")
      }else {
        print("Operation not completed")
      }
      
    }
    
  }
  
}