//
//  GCDOpNetwork.swift
//  swift-collections
//
//  Created by apple on 2020/9/4.
//

import UIKit

class GCDOpNetwork: NSObject {
    
    static var shared = GCDOpNetwork()
    func gcdNetwork() {
        let url = URL(string: "https://open.weixin.qq.com/qr/code?username=modu2049")!
        // let queue = DispatchQueue.global(qos: .default)
        let queue = DispatchQueue(label: "gcd", qos: .default, attributes: .concurrent)
        let group = DispatchGroup()
        
        for i in 0..<7 {
            queue.async(group: group, qos: .default, flags: []) {
                group.enter() //进入组
                self.downloadImage(url: url) {
                    print("finished action \(i)")
                    group.leave() //离开组
                }
            }
        }
        ///组中所有任务完成后收到的回调
        group.notify(qos: .default, flags: [], queue: queue) {
            print("All action were finisned!")
        }
    }
    
    func opQueueNetwork() {
        let url = URL(string: "https://open.weixin.qq.com/qr/code?username=modu2049")!
        
        let opqueue = OperationQueue()
        
        var ops = [BlockOperation]()
        let completed = BlockOperation {
            print("All Blcok Operation is completed!!")
        }
        for i in 0...15 {
            let op = BlockOperation {[weak self] in
                let semaphore = DispatchSemaphore(value: 0)
                
                self?.downloadImage(url: url) {
                    print("Operation \(i) is finished")
                    semaphore.signal()
                }
                semaphore.wait()
            }
            completed.addDependency(op)
            ops.append(op)
        }
        opqueue.addOperation(completed)
        for op in ops {
            opqueue.addOperation(op)
        }
    }
    
    func downloadImage(url: URL, completion:@escaping ()->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            sleep(1)
            guard let error = error else {
                completion()
                return
            }
            completion()
            print(error)
        }.resume()
    }
}
