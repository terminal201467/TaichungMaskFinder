//
//  ViewController.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    let network = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNetwork()
    }
    
    func setNetwork(){
        network.getData()
    }


}

