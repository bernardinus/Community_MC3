import UIKit

class CarouselViewController_: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalisation()
    }
    
    func loadLocalisation() {
        welcomeLabel?.text = NSLocalizedString("welcome to allegro".uppercased(), comment: "")
        accountLabel?.text = NSLocalizedString("have account".uppercased(), comment: "")
        btnNext.titleLabel?.text = NSLocalizedString("Get Started", comment: "")
        signInButton.titleLabel?.text = NSLocalizedString("Sign In", comment: "")
    }
  
    @IBAction func signInButtonTouched(_ sender: Any) {
        
        showLogin = true
        performSegue(withIdentifier: "signInFromOnboarding", sender: nil)
    }
}

