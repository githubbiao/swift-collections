//
//  TimerViewController.swift
//  demo
//
//  Created by apple on 2020/9/8.
//

import UIKit

class Proxy: NSObject {
    weak var target: AnyObject?
    var aSelector: Selector?
    weak var timer: Timer?
    
    deinit {
        print("proxy is deinit")
    }
}

class TimerViewController: UIViewController {
    var proxy = Proxy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray

        let timer = Timer(timeInterval: 1.0, target: proxy, selector: #selector(proxy.proxyAction(_:)), userInfo: nil, repeats: true)
        proxy.target = self
        proxy.aSelector = #selector(toShop(_:))
        proxy.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    
    @objc func toShop(_ sender: Timer) {
        print("\(Date()) \(sender)")
    }
    
    deinit {
        proxy.timer?.invalidate()
        print("-------")
    }
    
}

extension Proxy {
    @objc func proxyAction(_ sender: Timer) {
        if let timer = timer {
            (target as? TimerViewController)?.toShop(timer)
        }
    }
}
