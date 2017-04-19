//
//  Hello.swift
//  Villa Wewersbusch App
//
//  Created by Felix Kolewe on 11.03.17.
//  Copyright © 2017 Felix Kolewe. All rights reserved.
//

import Foundation

class Home: UIViewController {

    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
