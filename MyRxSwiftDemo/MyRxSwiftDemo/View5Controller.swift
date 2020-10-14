//
//  View5Controller.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/14.
//

import UIKit
import RxSwift
import RxCocoa

class View5Controller: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let controlEvent = actionButton.rx.controlEvent(.touchUpInside)
//        controlEvent.subscribe{ (result) in
//            print("订阅：\(result) \n \(Thread.current)")
//            
//        }.disposed(by: disposeBag)
        
        controlEvent.subscribe(onNext:{
            print("\(Thread.current)")
        }).disposed(by: disposeBag)
        
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
