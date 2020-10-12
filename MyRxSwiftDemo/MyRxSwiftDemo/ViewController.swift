//
//  ViewController.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/12.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!////用户名
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!//密码
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameErrorLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordErrorLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map{$0.count >= minimalUsernameLength}
            .share(replay: 1, scope: .whileConnected)
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map{$0.count >= minimalPasswordLength}
            .share(replay: 1, scope: .whileConnected)
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid){$0 && $1}
            .share(replay: 1, scope: .whileConnected)
        
        usernameValid.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        usernameValid.bind(to: usernameErrorLabel.rx.isHidden).disposed(by: disposeBag)
        passwordValid.bind(to: passwordErrorLabel.rx.isHidden).disposed(by: disposeBag)
        everythingValid.bind(to: actionButton.rx.isEnabled).disposed(by: disposeBag)
        
        actionButton.rx.tap
            .subscribe(onNext:{[weak self] in self?.showAlert()})
            .disposed(by: disposeBag)
        
    }


    func showAlert() {
        
        view.endEditing(true)
        let alertVC = UIAlertController.init(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Done", style: .default, handler: { (doneAction) in
            
        }))
        present(alertVC, animated: true) {
            
        }
        
    }
}

