//
//  AuthorizationViewController.swift
//  WeatherNyblecraft
//
//  Created by Alexei Sevko on 3/18/18.
//  Copyright © 2018 Alexei Sevko. All rights reserved.
//

import UIKit
import MBProgressHUD

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var segment: UISegmentedControl!
    
    private var viewModel = UserViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        usernameField.delegate = self
        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func changeState(_ sender: UISegmentedControl) {
        actionButton.setTitle(sender.titleForSegment(at: sender.selectedSegmentIndex), for: .normal)
    }
    
    @IBAction func authenticate(_ sender: Any) {
        switch viewModel.validate() {
        case .Valid:
            MBProgressHUD.showAdded(to: self.view, animated: true)
            guard let type = requestType() else {return}
            viewModel.login(type: type) {errorMessage in
                MBProgressHUD.hide(for: self.view, animated: true)
                if let errorMessage = errorMessage {
                    self.displayErrorMessage(errorMessage: errorMessage)
                } else {
                    //move to another screen
                    self.gotoForecast()
                }
            }
        case .Invalid(let error):
            displayErrorMessage(errorMessage: error)
        }
    }

}

//MARK: - TextFieldDelegate
extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameField {
            textField.text = viewModel.username
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameField {
            textField.text = viewModel.protectedUsername
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            authenticate(self)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == usernameField {
            viewModel.updateUsername(username: newString)
        } else if textField == passwordField {
            viewModel.updatePassword(password: newString)
        }
        
        return true
    }

}

//MARK: - private methods
private extension AuthorizationViewController {
    func displayErrorMessage(errorMessage: String) {
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func gotoForecast() {
//        if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController!.present(tabBarVC, animated: true, completion: nil)
//        }
       
        self.performSegue(withIdentifier: "AuthToMainSegue", sender: self)
    }
    
    func requestType() -> RequestType?{
        switch segment.selectedSegmentIndex {
        case 0:
            return RequestType.Login
        case 1:
            return RequestType.SignUp
        default:
            return nil
        }
    }
}
