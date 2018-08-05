//
//  ViewController.swift
//  ValidatorsMediumPost
//
//  Created by Arlind on 8/1/18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var projectIdTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindKeyboardNotifications()
    }
    
    @IBAction func validateAction(_ sender: Any) {
        validate()
    }
    
    func validate() {
        do {
            let email = try emailTextField.validatedText(validationType: ValidatorType.email)
            let username = try usernameTextField.validatedText(validationType: ValidatorType.username)
            let age = try self.ageTextField.validatedText(validationType: ValidatorType.age)
            let password = try passwordTextField.validatedText(validationType: ValidatorType.password)
            let projectId = try projectIdTextField.validatedText(validationType: ValidatorType.projectIdentifier)
            let department = try self.departmentTextField.validatedText(validationType: .requiredField(field: "Department"))
            let data = RegisterData(email: email, password: password, username: username, projectID: projectId, department: department, age: Int(age)!)
            save(data)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
    func save(_ data: RegisterData) {
        showAlert(for: "Register Successful")
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func bindKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { notification in
            let keyboardHeight: CGFloat = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            self.bottomConstraint.constant  = 20 + keyboardHeight
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { _ in
            self.bottomConstraint.constant = 20.0
        }
    }
}



