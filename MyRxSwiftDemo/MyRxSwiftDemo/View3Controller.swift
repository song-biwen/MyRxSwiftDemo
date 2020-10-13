//
//  View3Controller.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/13.
//

import UIKit
import RxSwift
import RxCocoa

class View3Controller: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createEmpty()
//        createJust()
//        createOf()
//        createFrom()
//        createDefer()
//        createRange()
//        createGenerate()
//        createTimer()
        createCreate()
    }
    
    /*
     *创建空的序列
     *输出结果
     *
     完成回调
     释放回调
     */
    func createEmpty() {
        let emptyOb = Observable<Int>.empty()
        _ = emptyOb.subscribe(onNext: { (number) in
            print("订阅\(number)")
        }, onError: { (error) in
            print("error",error)
        }, onCompleted: {
            print("完成回调")
        }, onDisposed: {
            print("释放回调")
        })
        
    }

    /*
     *Just
     *
     订阅： ["Lily", "Lucy"]
     完成回调
     释放回调
     */
    func createJust()  {
        let array = ["Lily","Lucy"]
//        Observable<[String]>.just(array).subscribe{
//            (event) in
//            print(event)
//        }
//        .disposed(by: disposeBag)
        
        _ = Observable<[String]>.just(array).subscribe(onNext: { (arr) in
            print("订阅：",arr)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("完成回调")
        }, onDisposed: {
            print("释放回调")
        })
    }

    /*
     *Of
     *
     订阅： Lily
     订阅： Lucy
     回调完成
     释放回调
     */
    func createOf() {
//        Observable<String>.of("Lily","Lucy")
//            .subscribe{(event) in
//                print(event)
//            }
//            .disposed(by: disposeBag)
        
        _ = Observable<String>.of("Lily","Lucy")
            .subscribe(onNext: { (string) in
                print("订阅：",string)
            }, onError: { (error) in
                print("error",error)
            }, onCompleted: {
                print("回调完成")
            }, onDisposed: {
                print("释放回调")
            })
    }
    
    
    /*
     *From
     *
     next(["Lily", "Lucy"])
     completed
     */
    func createFrom() {
        Observable<[String]>.from(optional: ["Lily","Lucy"]).subscribe{ (event) in
            print(event)
        }.disposed(by: disposeBag)


    }
    
    /*
     *deferred
     *
     next(0)
     next(2)
     next(4)
     next(6)
     next(8)
     completed
     */
    func createDefer() {
        var isOdd = true
        _ = Observable<Int>.deferred({ () -> Observable<Int> in
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1,3,5,7,9)
            }
            return Observable.of(0,2,4,6,8)
        }).subscribe({ (event) in
            print(event)
        })
    }
    
    /*
     *Range
     *
     订阅: 2
     订阅: 3
     订阅: 4
     订阅: 5
     订阅: 6
     回调完成
     释放回调
     */
    func createRange() {
        _ = Observable.range(start: 2, count: 5).subscribe(onNext: { (num) in
            print("订阅:",num)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("回调完成")
        }, onDisposed: {
            print("释放回调")
        })
    }
    
    /*
     *Generate
     *
     订阅: 1
     订阅: 2
     订阅: 3
     订阅: 4
     订阅: 5
     订阅: 6
     订阅: 7
     订阅: 8
     订阅: 9
     回调完成
     释放回调

     */
    func createGenerate() {
        _ = Observable.generate(initialState: 0, condition: {$0<10}, iterate: {$0+1})
            .subscribe(onNext: { (num) in
                print("订阅:",num)
            }, onError: { (error) in
                print("error:",error)
            }, onCompleted: {
                print("回调完成")
            }, onDisposed: {
                print("释放回调")
            })
        
    }
    
    func createTimer() {
        
        Observable<Int>.timer(5, period: 2, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
    }
    
    /*
     *create
     *
     next(Hello World)
     completed
     */
    func createCreate() {
        let observable = Observable<String>.create { observer in
            observer.onNext("Hello World")
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
    }
}
