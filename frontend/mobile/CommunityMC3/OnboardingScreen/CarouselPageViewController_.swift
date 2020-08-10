import Foundation
import UIKit

class CarouselPageViewController_: UIPageViewController {
    
    fileprivate var items: [UIViewController] = {
        let sb = UIStoryboard(name: "OnboardingScreen", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "onboardingView1") as! OnboardingView1
        let vc2 = sb.instantiateViewController(withIdentifier: "onboardingView2") as! OnboardingView2
        let vc3 = sb.instantiateViewController(withIdentifier: "onboardingView3") as! OnboardingView3
        
        
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        decoratePageControl()
        
//        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController_.self])
        pc.currentPageIndicatorTintColor = .magenta
        pc.pageIndicatorTintColor = .gray
    }
    
    fileprivate func populateItems() {
        let text = ["🎖", "👑", "🥇"]
        let backgroundColor:[UIColor] = [.blue, .red, .green]
        
        for (index, t) in text.enumerated() {
            let c = createCarouselItemControler(with: t, with: backgroundColor[index])
            items.append(c)
        }
    }
    
    fileprivate func createCarouselItemControler(with titleText: String?, with color: UIColor?) -> UIViewController {
        let c = UIViewController()
        c.view = CarouselItem(titleText: titleText, background: color)

        return c
    }
}

// MARK: - DataSource

extension CarouselPageViewController_: UIPageViewControllerDataSource {
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

class OnboardingView1: UIViewController {
    
    @IBOutlet weak var onboardingOneTitleLabel: UILabel!
    @IBOutlet weak var onboardingOneDescLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalisation()
    }
    
    func loadLocalisation() {
        onboardingOneTitleLabel?.text = NSLocalizedString("onboarding_1_title".uppercased(), comment: "")
        onboardingOneDescLabel?.text = NSLocalizedString("onboarding_1_desc".uppercased(), comment: "")
    }
    
}

class OnboardingView2: UIViewController {
    
    @IBOutlet weak var onboardingTwoTitle: UILabel!
    @IBOutlet weak var onboardingTwoDesc: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       loadLocalisation()
   }
       
   func loadLocalisation() {
       onboardingTwoTitle?.text = NSLocalizedString("Random Spotlight", comment: "")
       onboardingTwoDesc?.text = NSLocalizedString("onboarding_2_desc".uppercased(), comment: "")
   }
}

class OnboardingView3: UIViewController {
    
    @IBOutlet weak var onboardingThreeTitle: UILabel!
    @IBOutlet weak var onboardingThreeDescription: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       loadLocalisation()
   }
       
   func loadLocalisation() {
       onboardingThreeTitle?.text = NSLocalizedString("onboarding_3_title".uppercased(), comment: "")
       onboardingThreeDescription?.text = NSLocalizedString("onboarding_3_desc".uppercased(), comment: "")
   }
}
