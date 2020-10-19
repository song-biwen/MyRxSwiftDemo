//
//  UTable2VC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/16.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//使用系统的Section  单个section
class UTable2VC: UIViewController {

    //tableview
    var tableView:UITableView!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableview初始化
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        
        //初始化数据(使用自带的Section)
        let items = Observable.just([
            SectionModel(model: "", items: [
                "UILabel的用法",
                "UIText的用法",
                "UIButton的用法",
            ])
        ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = item
            return cell!
            
        }
        
        //绑定单元格数据
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
