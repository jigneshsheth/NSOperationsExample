//
//  AppDelegate.swift
//  MultiThreading
//
//  Created by Jigs Sheth on 12/31/15.
//  Copyright © 2015 jigneshsheth.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
//    self.blockOperationTest()
//    self.dependencyBlock()
    self.customOperation()
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  
  /**
  *  Private Methods
  */

   /**
   Using NSBlockOperations
   */
  func blockOperationTest(){

    let operationQueue = NSOperationQueue()
    let operation1:NSBlockOperation = NSBlockOperation { () -> Void in
      self.doSomeComputation()
      let operation2:NSBlockOperation = NSBlockOperation(block: { () -> Void in
        self.doSomeMoreComputation()
      })
       operationQueue.addOperation(operation2)
    }
    operationQueue.addOperation(operation1)
    
  }
  
  func doSomeComputation(){
    print("Doing some Computation")
    for i in 100...105 {
      print(" Calculatin \(i)")
    }
    sleep(1)
  }
  
  
  func doSomeMoreComputation(){
    print("---------- Doing some More Computation --------------")
    for i in 200...205 {
      print(" Calculatin \(i)")
    }
    sleep(1)
  }
  
  /**
   Example of dependency queue
   */
  func dependencyBlock(){
    let operationQueue = NSOperationQueue.mainQueue()
    
    let completionBlock1:NSBlockOperation = NSBlockOperation.init(block: {
       print("::Dependent Completion Block 1::")
      })
    
    let workerBlock:NSBlockOperation = NSBlockOperation.init(block: {
      print("::WorkerBlock Block 2::")
      self.doSomeMoreComputation()
    })

    completionBlock1.addDependency(workerBlock)
    operationQueue.addOperation(completionBlock1)
    operationQueue.addOperation(workerBlock)
    
  }
  
  
  func customOperation(){
    
    let operationQueue = NSOperationQueue.mainQueue()
    
    
    let customOperation = MyCustomOperation()
    
    customOperation.completionBlock = {
      print("Custom Operation Completion Block !!")
    }

    let workerBlock:NSBlockOperation = NSBlockOperation.init(block: {
      print("::WorkerBlock Block ::")
      self.doSomeMoreComputation()
    })

    customOperation.addDependency(workerBlock)
    operationQueue.addOperations([customOperation,workerBlock], waitUntilFinished: false)
    
    
  }
  
  
}

