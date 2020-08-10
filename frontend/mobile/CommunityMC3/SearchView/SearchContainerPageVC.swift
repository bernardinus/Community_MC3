//
//  SeachContainerPageVC.swift
//  CommunityMC3
//
//  Created by Theofani on 28/07/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SearchContainerPageVC: UIPageViewController {
    
    var callback:((UserDataStruct)->Void)? = nil
    
    lazy var items: [UIViewController] = {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "allSearch")
        let vc2 = sb.instantiateViewController(withIdentifier: "artistSearch")
        let vc3 = sb.instantiateViewController(withIdentifier: "musicSearch")
        let vc4 = sb.instantiateViewController(withIdentifier: "videoSearch")
        let vc5 = sb.instantiateViewController(withIdentifier: "playlistSearch")
        
        return [vc1, vc2, vc3, vc4, vc5]
    }()
    
    var cVC:UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = nil
        self.delegate = nil
        
    }
    
    func moveToPageSearch(index:Int)
    {
        let nextVC = [items[index]]
        cVC = nextVC[0]
        
        switch index {
        case 0:
            let currentSearchVC = cVC as! AllSearchVC
            currentSearchVC.callback = callback
        case 1:
            let currentSearchVC = cVC as! ArtistSearchVC
            currentSearchVC.callback = callback
        default:
            print("Other search go here")
        }
        setViewControllers(nextVC, direction: .forward, animated: false, completion: nil)
    }
    
    func updateResultTable()
    {
        if cVC is AllSearchVC
        {
            let currentSearchVC = cVC as! AllSearchVC
            currentSearchVC.allSearchTableView.reloadData()
        }
        else if cVC is ArtistSearchVC
        {
            let currentSearchVC = cVC as! ArtistSearchVC
            currentSearchVC.artistSeachTableView.reloadData()
        }
        else if cVC is MusicSearchVC
        {
            let currentSearchVC = cVC as! MusicSearchVC
            currentSearchVC.musicSearchTableView.reloadData()
        }
        else if cVC is VideoSearchVC
        {
            let currentSearchVC = cVC as! VideoSearchVC
            currentSearchVC.videoSearchTableView.reloadData()
        }
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
