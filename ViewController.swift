//
//  ViewController.swift
//  MyEvent
//
//  Created by goldorak on 31/01/2022.
//

import UIKit
import Model

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestFactory = RequestFactory()
        requestFactory.getFurnitureList { 
            (errorHandle, furnitures) in 
            if let _ = errorHandle.errorType, let errorMessage = errorHandle.errorMessage {
                print(errorMessage)
            }
            else if let list = furnitures, let furniture = list.last {
                print(furniture.id)
            }
            else {
                print("Houston we got a problem")
            }
        }
    }
}

