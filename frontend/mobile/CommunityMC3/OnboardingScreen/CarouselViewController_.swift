import UIKit

class CarouselViewController_: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func signInButtonTouched(_ sender: Any) {
        
        showLogin = true
        performSegue(withIdentifier: "signInFromOnboarding", sender: nil)
    }
}

