//
//  ViewController.swift
//  HelloTigerProtocol
//
//  Created by Sebastian Buys on 3/7/19.
//  Copyright © 2019 Sebastian Buys. All rights reserved.
//

import UIKit

class Tiger {
    let maxZebras = 5
    var zebrasEaten: Int = 0
    
    weak var delegate: TigerDelegate?
    
    // Alternatively we can use a callback function
    // But don't get the guarantees of protocol
    var tigerDidGetFull: (() -> Void)?
    
    func eat() {
        zebrasEaten += 1
        let name = delegate?.tellMeYourName() ?? ""
        print("yum yum! Thank \(name)! I've eaten \(zebrasEaten) zebras!")
        
        if zebrasEaten == maxZebras {
            delegate?.tigerDidGetFull()
            tigerDidGetFull?()
        }
    }
    
    func poke() {
        delegate?.tigerDidGetAngry()
    }
}

protocol TigerDelegate: class {
    func tigerDidGetFull()
    func tigerDidGetAngry()
    func tellMeYourName() -> String
}

class ViewController: UIViewController, TigerDelegate {
    func tigerDidGetAngry() {
    }
    
    func tellMeYourName() -> String {
        return "Nien"
    }
    
    var tigerIsFull: Bool = false
    
    func tigerDidGetFull() {
        print("Tiger is full! Don't feed!")
        tigerIsFull = true
    }
    
    let tiger = Tiger()
    override func viewDidLoad() {
        super.viewDidLoad()
        tiger.delegate = self
        
        tiger.tigerDidGetFull = { [weak self] in
            
        }
        
        for _ in 0...100 {
            if !tigerIsFull {
                tiger.eat()
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

