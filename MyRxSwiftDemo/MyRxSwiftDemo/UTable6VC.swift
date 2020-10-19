//
//  UTable6VC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//搜索
class UTable6VC: UIViewController {

    var tableView:UITableView!
    var searchBar:UISearchBar!
    var rightBarButtonItem:UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //rightBarButtonItem 初始化
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.setTitle("刷新", for: .normal)
        rightButton.setTitleColor(UIColor.blue, for: .normal)
        rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        //随机的表格数据
        let randomData = rightButton.rx.tap.asObservable()
            .startWith(())
            .flatMapLatest(getRandomData)
            .flatMap(filterResult)
            .share(replay: 1, scope: .whileConnected)
        
        
        //searchBar初始化
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 56))
        
        //tableView初始化
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        
        //数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Int>> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = "条目\(indexPath.row):\(item)"
            return cell!
        }
        
        //绑定单元格数据
        randomData.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    //获取随机数据
    func getRandomData() -> Observable<[SectionModel<String, Int>]> {
        
        self.view.endEditing(true)
        
        let items = (0..<15).map { _ in
            return Int(arc4random())
        }
        
        let observable = Observable.just([
            SectionModel(model: "", items: items)
        ])
        
        return observable.throttle(RxTimeInterval.milliseconds(2000), scheduler: MainScheduler.instance)
        
    }

    //过滤数据
    func filterResult(data:[SectionModel<String,Int>])->Observable<[SectionModel<String,Int>]> {
        
        return self.searchBar.rx.text.orEmpty
            .flatMapLatest{
                query -> Observable<[SectionModel<String,Int>]> in
                
                if query.isEmpty {
                    return Observable.just(data)
                }else {
                    var _items:[SectionModel<String,Int>] = []
                    for sectionModel in data {
                        let items = sectionModel.items.filter({"\($0)".contains(query)})
                        _items.append(SectionModel(model: sectionModel.model, items: items))
                        
                    }
                    return Observable.just(_items)
                    
                }
            }
    }
}
