//
//  CustomViewController.swift
//  CommunityMC3
//
//  Created by Theofani on 25/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class CustomViewController: UIViewController {

    @IBOutlet weak var swipeMenuView: SwipeMenuView!

    var array = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self

        let options: SwipeMenuViewOptions = .init()

        swipeMenuView.reloadData(options: options)

    }
}

extension CustomViewController: SwipeMenuViewDelegate {

    // MARK - SwipeMenuViewDelegate
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        // Codes
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        // Codes
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        // Codes
    }
}

extension CustomViewController: SwipeMenuViewDataSource {

    //MARK - SwipeMenuViewDataSource
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return array.count
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return array[index]
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = ContentViewController()
        return vc
    }
}
