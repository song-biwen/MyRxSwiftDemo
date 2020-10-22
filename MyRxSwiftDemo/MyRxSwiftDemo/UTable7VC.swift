//
//  UTable7VC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class UTable7VC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化UI
        self.view.addSubview(tableView)
        
        //初始化数据
        let items = Observable.just([
            "苹果",
            "香蕉🍌",
            "橘子🍊",
            "柚子"
        ])
        
        //绑定单元格
        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        //cell点击事件
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext:{
                print($0)
            })
            .disposed(by: disposeBag)
        
    }
    
    lazy var tableView:UITableView = {
        //tableview初始化
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        //注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //去掉cell分割线
        tableView.separatorStyle = .none
        //去掉tableview底部多余的cell
        tableView.tableFooterView = UIView()
        return tableView
    }()

}
