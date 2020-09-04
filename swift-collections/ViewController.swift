//
//  ViewController.swift
//  swift-collections
//
//  Created by apple on 2020/9/4.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let shared = GCDOpNetwork.shared
        // shared.gcdNetwork()
        shared.opQueueNetwork()
    }


}

