//
//  CarouselPageViewController.swift
//  CommunityMC3
//
//  Created by Theofani on 27/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class CarouselPageViewController: UIPageViewController {
    
    lazy var items: [UIViewController] = {
        let sb = UIStoryboard(name: "UserProfileView", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "secondPageView")
        let vc2 = sb.instantiateViewController(withIdentifier: "firstPageView")
        
        return [vc1, vc2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.dataSource = nil
        self.delegate = nil
        
    }
    
    func moveToPage(index:Int)
    {
        setViewControllers([items[index]], direction: .forward, animated: true, completion: nil)
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
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
