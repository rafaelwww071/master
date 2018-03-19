//
//  AuthViewController.swift
//  SignTestApp
//
//  Created by Rafael Mukhametov on 16.03.18.
//  Copyright © 2018 Rafael Mukhametov. All rights reserved.
//

import UIKit
import Alamofire

class AuthViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passField: UITextField!
    var temp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Авторизация"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        authButton.clipsToBounds = true
        
        authButton.layer.cornerRadius = authButton.frame.size.height / 2
        emailLabel.bounds.size.width = passLabel.bounds.size.width
        emailField.bounds.size.width = passLabel.bounds.size.width
        passField.bounds.size.width = passLabel.bounds.size.width
        emailField.setNeedsDisplay()
        passField.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authButtonAction(sender: UIButton){
        if isValidEmail(email: emailField.text) && isValidPassword(pass: passField.text) {
            requestJSON()
        }else{
            let alertView = UIAlertController(title: "Проверьте правильность введенных данных", message: "Проверьте правильность введенных данных, а затем повторите попытку", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
        }
    }
    
    func requestJSON() {
        Alamofire.request("http://samples.openweathermap.org/data/2.5/find?q=London&units=metric&appid=f1e0f35db0fee0d58f0bbbeab98279e6", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            if let result = response.result.value {
                let json = result as! NSDictionary
                let list = json["list"] as! NSArray
                let main = (list[0] as AnyObject).value(forKey: "main") as AnyObject
                self.temp = main.value(forKey: "temp") as! Int
                print(self.temp)
                let alertView = UIAlertController(title: "Погода в Лондоне", message: "На данный момент температура в Лондоне равна \(self.temp) °C", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    func isValidPassword(pass:String?) -> Bool {
        guard pass != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
        return passwordTest.evaluate(with: pass)
    }
    
    @objc func keyboardShow(notification: NSNotification)  {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.view.frame.origin.y = 0
            if UIScreen.main.bounds.height == 568.0 {
                self.view.frame.origin.y -= 160
            }else{
                self.view.frame.origin.y -= 115
            }
        }
    }
    @objc func keyboardHide(notification: NSNotification)  {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
