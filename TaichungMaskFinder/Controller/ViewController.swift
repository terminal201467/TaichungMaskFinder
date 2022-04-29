//
//  ViewController.swift
//  TaichungMaskFinder
//
//  Created by Jhen Mu on 2022/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let maskView = View()
    
    private let network = NetworkController()
    
    override func loadView() {
        super.loadView()
        view = maskView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNetwork()
        
    }
    
    private func setNetwork(){
        network.getData()
//        network.filter(county: "臺中市")
        
        network.valueChanged = {
            print("台中:",self.network.taichungData.count)
            
        }
    }
    
    
    
}

