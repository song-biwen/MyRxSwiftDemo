//
//  UTable5VC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//刷新表格数据
class UTable5VC: UIViewController {

    var tableView:UITableView!
    var rightBarButtonItem: UIBarButtonItem!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView初始化
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //rightBarButtonItem 初始化
        let rightButton = UIButton(type: .custom)
        rightButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightButton.setTitle("刷新", for: .normal)
        rightButton.setTitleColor(UIColor.blue, for: .normal)
        self.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        self.navigationItem.title = "HHH"
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        //随机的表格数据
        let randomResult = rightButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest({
                self.getRandomResult()
            })
            .share(replay: 1)
        
        //数据源初始化
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = "条目\(indexPath.row):\(item)"
            return cell!
        }
        
        
        //绑定数据源
        randomResult.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    

    func getRandomResult() -> Observable<[SectionModel<String, Int>]>{
        print("正在请求数据...")
        let items = (0..<5).map { _ in
            Int(arc4random())
        }
        let observable = Observable.just([
            SectionModel(model: "", items: items)
    
        ])
        
        return observable.throttle(RxTimeInterval.milliseconds(2000), scheduler: MainScheduler.instance)
    }

}
