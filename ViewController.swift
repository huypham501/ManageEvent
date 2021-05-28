//
//  ViewController.swift
//  ManageEvent
//
//  Created by TMA on 26/05/2021.
//

import UIKit

class ViewController: UIViewController {

    let eventManager : EventManager = EventManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
    override func viewDidAppear(_ xanimated: Bool) {
        let authorStatus = eventManager.checkAuthorization()
        
        // CHECK AUTHOR IF NOT -> REQUEST
        if !authorStatus {
            alertDeniedAuthor()
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func alertDeniedAuthor(){
        let alertController = UIAlertController(title: "Access alert", message: "Calendar access is denied", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Request", style: UIAlertAction.Style.default, handler: test()))

            print("Present alert")
        present(alertController, animated: true, completion: nil)
    }
    
    private func test() {
        print("HEREEEE")
    }

}

