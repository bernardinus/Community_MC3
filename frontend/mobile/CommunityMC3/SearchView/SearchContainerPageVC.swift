//
//  SeachContainerPageVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SearchContainerPageVC: UIPageViewController {
    
    lazy var items: [UIViewController] = {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "allSearch")
        let vc2 = sb.instantiateViewController(withIdentifier: "artistSearch")
        let vc3 = sb.instantiateViewController(withIdentifier: "musicSearch")
        let vc4 = sb.instantiateViewController(withIdentifier: "videoSearch")
        let vc5 = sb.instantiateViewController(withIdentifier: "playlistSearch")
        
        return [vc1, vc2, vc3, vc4, vc5]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = nil
        self.delegate = nil
        
    }
    
    func moveToPageSearch(index:Int)
    {
        setViewControllers([items[index]], direction: .forward, animated: false, completion: nil)
    }
    
}

// MARK: - DataSource
extension SearchContainerPageVC: UIPageViewControllerDataSource {
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
