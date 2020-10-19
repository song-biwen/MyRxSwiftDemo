//
//  UTable4VC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//使用自带的section，多个section
class UTable4VC: UIViewController {

    var tableView:UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView初始化
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //数据初始化
        let items = Observable.just([
            SectionModel(model: "基本控件", items: [
                "UILabel的用法",
                "UIText的用法",
                "UIButton的用法"
            ]),
            SectionModel(model: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
            ])
        ])
        
        //数据源初始化
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = item
            return cell!
            
        }
        
        dataSource.titleForHeaderInSection = { dataSource,index in
            return dataSource.sectionModels[index].model
        }
        
        //绑定数据源
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
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
