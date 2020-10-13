//
//  View4Controller.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/13.
//

import UIKit
import RxCocoa
import RxSwift

class View4Controller: UIViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        startWith()
//        grammarMerge()
//        grammarZip()
//        grammarCombineLatest()
//        grammarSwitchLatest()
        grammarMap()
    }
    
    /*
     *startWith
     *输出
     *
     9
     8
     0
     1
     2
     3
     4
     5
     */

    func startWith() {
        Observable.of(1,2,3,4,5)
            .startWith(0)
            .startWith(9,8)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }

    /*
     *Merge
     *输出
     *
     1
     2
     A
     B
     3
     C
     */
    
    func grammarMerge() {
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        Observable.merge(subject1,subject2)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
        subject1.onNext("1")
        subject1.onNext("2")
        subject2.onNext("A")
        subject2.onNext("B")
        subject1.onNext("3")
        subject2.onNext("C")
    }
    
    /*
     *Zip
     */
    func grammarZip() {
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject)
            .subscribe(onNext:{(string,num) in
                print("\(string)---\(num)")
            })
            .disposed(by: disposeBag)
        
        stringSubject.onNext("A")
        stringSubject.onNext("B")
        /*
         输出：空
         */
        intSubject.onNext(1)
        /*
         输出：A---1
         */
        intSubject.onNext(2)
        /*
         输出：
         A---1
         B---2
         */
    }
    
    /*
     *combineLatest
     */
    func grammarCombineLatest() {
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.combineLatest(stringSubject, intSubject)
            .subscribe(onNext:{(string,num) in
                print("\(string)---\(num)")
            })
            .disposed(by: disposeBag)
        
        stringSubject.onNext("A")
        stringSubject.onNext("B")
        
        /*
         输出：空
         */
        intSubject.onNext(1)
        /*
         输出：B---1
         */
        intSubject.onNext(2)
        /*
         输出：
         B---1
         B---2
         */
    }
    
    func grammarSwitchLatest() {
        let switchLatestSub1 = BehaviorSubject(value: "L")
        let switchLatestSub2 = BehaviorSubject(value: "1")
        let switchLatestSub = BehaviorSubject(value: switchLatestSub1)
        
        switchLatestSub.asObserver()
            .switchLatest()
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
        
        /*
         输出：L
         */
        switchLatestSub1.onNext("G")
        /*
         输出：
         L
         G
         */
        switchLatestSub1.onNext("_")
        /*
         输出：
         L
         G
         _
         */
        
        switchLatestSub2.onNext("2")
        switchLatestSub2.onNext("3")
        switchLatestSub.onNext(switchLatestSub2)
        /*
         输出：
         L
         G
         _
         3
         */
        switchLatestSub1.onNext("*")
        switchLatestSub1.onNext("cooci")
        switchLatestSub2.onNext("4")
        
        /*
         输出：
         L
         G
         _
         3
         4
         */
        
    }
    
    /*
     *Map
     */
    func grammarMap() {
        Observable.of(1,2,3,4)
            .map { (num) -> Int in
                return num * 2
            }
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
}
