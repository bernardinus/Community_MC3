//
//  CarouselPageViewController.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class CarouselPageViewController: UIPageViewController {

    fileprivate var items: [UIViewController] = []

    var a:String = "pvc"
   override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
    
        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }
    }
    
    fileprivate func populateItems() {
        let text = ["First", "Second"]
        let backgroundColor:[UIColor] = [.blue, .green]
        
        for (index, t) in text.enumerated() {
            let c = createCarouselItemControler(with: t, with: backgroundColor[index])
            items.append(c)
        }
    }
    
    fileprivate func createCarouselItemControler(with titleText: String?, with color: UIColor?) -> UIViewController {
        let c = UIViewController()
        c.view = CarouselItem(titletext: titleText, background: color)

        return c
    }
    func moveToPage(index:Int)
    {
        if index == 0 {
            setViewControllers([items[index]], direction: .reverse, animated: true, completion: nil)
        }
        if index == 1 {
            setViewControllers([items[index]], direction: .forward, animated: true, completion: nil)
        }

    }
}

// MARK: - DataSource
extension CarouselPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
//    func presentationCount(for _: UIPageViewController) -> Int {
//        return items.count
//    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
