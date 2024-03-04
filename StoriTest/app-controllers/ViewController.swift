//
//  ViewController.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 01/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = HomeRouter.createModule()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
