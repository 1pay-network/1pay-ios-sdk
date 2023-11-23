import UIKit
import OnePaySDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onStartPressed(_ sender: Any) {
        OnePay.pay(self, amount: 0.1, token: "usdt", note: "this is demo note") { [weak self] response in
            if (response.success) {
                print("Success", response)
            } else {
                print("Failed", response)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

