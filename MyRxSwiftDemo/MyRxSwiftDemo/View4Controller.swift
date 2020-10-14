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
//        grammarMap()
//        grammarScan()
//        grammarFilter()
//        grammarDistinctUntilChanged()
//        grammarElementAt()
//        grammarSingle()
//        grammarTake()
//        grammarTakeLast()
//        grammarTakeWhile()
//        grammerTakeUntil()
//        grammarSkip()
//        grammarSkipWhile()
//        grammerSkipUntil()
//        grammarToArray()
//        grammarReduce()
//        grammarConcat()
//        grammarCatchErrorJustReturn()
//        grammarCatchError()
//        grammarRetry()
        grammarRetry2()
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
     *
     2
     4
     6
     8
     */
    func grammarMap() {
        Observable.of(1,2,3,4)
            .map { (num) -> Int in
                return num * 2
            }
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *scan
     *
     11
     111
     1111
     */
    func grammarScan() {
        Observable.of(10,100,1000)
            .scan(1) { (total, num) -> Int in
                return total + num
            }
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *filter
     *
     2
     4
     6
     8
     0
     */
    func grammarFilter() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .filter { (num) -> Bool in
                return num % 2 == 0
            }
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    /*
     *distinctUntilChanged
     *输出
     *
     1
     2
     3
     0
     */
    func grammarDistinctUntilChanged() {
        Observable.of(1,2,2,3,3,3,3,0)
            .distinctUntilChanged()
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *elementAt
     *输出
     *
     3
     */
    func grammarElementAt() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .elementAt(2)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    func grammarSingle() {
//        Observable.of("Lily","Lucy")
//            .single()
//            .subscribe(onNext:{print($0)})
//            .disposed(by: disposeBag)
        /*
         输出
         Lily
         Unhandled error happened: Sequence contains more than one element.
         */
        Observable.of("Lily","Lucy")
            .single { (item) -> Bool in
                return item == "Lucy"
            }
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
        /*
         输出
         Lucy
         */
    }
    
    
    /*
     *take
     *输出
     *
     1
     2
     */
    func grammarTake() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .take(2)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *takeLast
     *输出
     *
     9
     0
     */
    func grammarTakeLast() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .takeLast(2)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *takeWhile
     *输出
     *
     1
     2
     3
     4
     */
    func grammarTakeWhile() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .takeWhile({ (item) -> Bool in
                return item < 5
            })
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *takeUntil
     *输出
     *
     A
     B
     */
    func grammerTakeUntil() {
        let sourceSub = PublishSubject<String>()
        let referenceSub = PublishSubject<String>()
        
        sourceSub
            .takeUntil(referenceSub)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
        
        sourceSub.onNext("A")
        sourceSub.onNext("B")
        referenceSub.onNext("1")
        sourceSub.onNext("C")
        
    }
    
    /*
     *skip
     *输出
     *
     3
     4
     5
     6
     7
     8
     9
     0
     */
    func grammarSkip() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .skip(2)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *skipWhile
     *输出
     *
     9
     0
     */
    func grammarSkipWhile() {
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .skipWhile({ (item) -> Bool in
                return item <= 8
            })
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *skipUntil
     *输出
     *
     C
     */
    func grammerSkipUntil() {
        let sourceSub = PublishSubject<String>()
        let referenceSub = PublishSubject<String>()
        
        sourceSub
            .skipUntil(referenceSub)
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
        
        sourceSub.onNext("A")
        sourceSub.onNext("B")
        referenceSub.onNext("1")
        sourceSub.onNext("C")
        
    }
    
    /*
     *toArray
     *输出
     *
     success([1, 2, 3])
     */
    func grammarToArray() {
        Observable.range(start: 1, count: 3)
            .toArray()
            .subscribe({print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *reduce
     *输出
     *
     1111
     */
    func grammarReduce() {
        Observable.of(10,100,1000)
            .reduce(1) { (a, b) -> Int in
                return a+b
            }
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
    }
    
    /*
     *reduce
     */
    func grammarConcat() {
        let subjectA = BehaviorSubject(value: "A")
        let subject1 = BehaviorSubject(value: "1")
        let subject = BehaviorSubject(value: subjectA)
        
        subject.asObserver()
            .concat()
            .subscribe(onNext:{print($0)})
            .disposed(by: disposeBag)
        
        subjectA.onNext("B")
        subjectA.onNext("C")
        
        subject.onNext(subject1)
        subject1.onNext("2")
        subject1.onNext("3")
        /*
         输出
         A
         B
         C
         */
        
        subjectA.onCompleted()
        /*
         输出
         A
         B
         C
         3
         */
        subject1.onNext("4")
        /*
         输出
         A
         B
         C
         3
         4
         */
    }
    
    func grammarCatchErrorJustReturn() {
        let subject = PublishSubject<String>()
        subject.asObserver()
            .catchErrorJustReturn("Hello")
            .subscribe({print($0)})
            .disposed(by: disposeBag)
        
        subject.onNext("A")
        subject.onNext("B")
        /*
         输出
         next(A)
         next(B)
         */
        subject.onError(MyError.A)
        /*
         输出
         next(A)
         next(B)
         next(Hello)
         completed
         */
    }
    
    /*
     *catchError
     next(A)
     next(B)
     error B
     next(1)
     next(2)
     */
    func grammarCatchError() {
        let recoverySubject = PublishSubject<String>()
        let failSubject = PublishSubject<String>()
        
        failSubject.catchError { (error) -> Observable<String> in
            print("error",error)
            return recoverySubject
        }
        .subscribe({print($0)})
        .disposed(by: disposeBag)
        
        failSubject.onNext("A")
        failSubject.onNext("B")
        failSubject.onError(MyError.B)
        failSubject.onNext("C")
        recoverySubject.onNext("1")
        recoverySubject.onNext("2")
    }
    
    /*
     *retry
     next(A)
     next(B)
     错误序列来了
     next(A)
     next(B)
     next(1)
     next(2)
     completed

     */
    func grammarRetry() {
        
        var count = 1
        let failSubject = Observable<String>.create { (observer) -> Disposable in
            
            observer.onNext("A")
            observer.onNext("B")
            if count == 1 {
                observer.onError(MyError.A)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("1")
            observer.onNext("2")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        failSubject.retry()
            .subscribe({print($0)})
            .disposed(by: disposeBag)
        
    }
    
    /*
     *retry
     next(A)
     next(B)
     错误序列来了
     next(A)
     next(B)
     错误序列来了
     error(A)

     */
    func grammarRetry2() {
        
        var count = 1
        let failSubject = Observable<String>.create { (observer) -> Disposable in
            
            observer.onNext("A")
            observer.onNext("B")
            if count < 6 {
                observer.onError(MyError.A)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("1")
            observer.onNext("2")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        failSubject.retry(2)
            .debug()
            .subscribe({print($0)})
            .disposed(by: disposeBag)
        
    }
}

enum MyError:Error {
    case A
    case B
}
