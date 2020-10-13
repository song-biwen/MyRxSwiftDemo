//
//  View2Controller.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/13.
//

import UIKit
import RxSwift
import RxCocoa

class View2Controller: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //按钮点击事件
        actionButton.rx.tap
            .subscribe(onNext:{ [weak self] in
                self?.showAlert(message: "按钮被点击了")
                
            })
            .disposed(by: disposeBag)
        
        //监听textfield的输入内容改变
        textField.rx.text.orEmpty.changed.subscribe(onNext:{ (text) in
            print("监听到了-\(text)")
        })
        .disposed(by: disposeBag)
        
        //将textfield text与按钮标题进行绑定
        textField.rx.text.bind(to: actionButton.rx.title()).disposed(by: disposeBag)
        
        //给textfield添加点击事件
        let tapGestureRecognizer = UITapGestureRecognizer()
        textField.addGestureRecognizer(tapGestureRecognizer)
        textField.isUserInteractionEnabled = true
        tapGestureRecognizer.rx.event.subscribe(onNext:{
            (event) in
            print("textfield 被点击了")
        })
        .disposed(by: disposeBag)
        
        
        //网络请求
        URLSession.shared.rx.response(request: URLRequest(url: URL(string: "https://www.baidu.com")!))
            .subscribe(onNext:{(response, data) in
                print("网络请求----\(data)")
            },onError: { (error) in
                
            }).disposed(by: disposeBag)
    }
    

    func showAlert(message: String) {
        let alertVC = UIAlertController.init(title: message, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "Done", style: .default, handler: { (void) in
            
        }))
        present(alertVC, animated: true) {
            
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
