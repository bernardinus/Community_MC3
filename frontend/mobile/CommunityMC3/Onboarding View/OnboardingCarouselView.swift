//
//  OnboardingCarouselView.swift
//  Allegro
//
//  Created by Theofani on 05/08/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class OnboardingCarouselView: UIPageViewController {
    
    lazy var items: [UIViewController] = {
        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "onboardingView1")
        let vc2 = sb.instantiateViewController(withIdentifier: "onboardingView2")
        let vc3 = sb.instantiateViewController(withIdentifier: "onboardingView3")
        
        
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = nil
        self.delegate = nil
        
        decoratePageControl()
        if let firstViewController = items.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
               }
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingCarouselView.self])
        pc.currentPageIndicatorTintColor = .magenta
        pc.pageIndicatorTintColor = .gray
    }
    
    
}

extension OnboardingCarouselView: UIPageViewControllerDataSource {
    
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
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
