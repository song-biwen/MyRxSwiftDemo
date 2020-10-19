//
//  UTable3VC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//使用自定义的Section  单个section
class UTable3VC: UIViewController {

    var tableView:UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableview初始化
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //数据初始化
        let items = Observable.just([
            MySection(header: "", items: [
                "UILabel的用法",
                "UIText的用法",
                "UIButton的用法",
            ])
        ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = item
            return cell
            
        }
        
        //绑定数据
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    
}


//自定义section
struct MySection {
    var header:String
    var items:[Item]
}

extension MySection:AnimatableSectionModelType {
    typealias Item = String
    
    var identity:String {
        return header
    }
    
    init(original:MySection, items:[Item]) {
        self = original
        self.items = items
    }
    
}

