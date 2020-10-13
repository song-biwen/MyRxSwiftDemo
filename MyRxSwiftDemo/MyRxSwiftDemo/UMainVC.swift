//
//  UMainVC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/13.
//

import UIKit
import RxSwift
import RxCocoa

class UMainVC: UIViewController,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    let names = ["ViewController","View2Controller"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "首页"
        
        //tableview 数据源
        let items = Observable.just(names)
        
        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)){ (row, element, cell) in
            cell.textLabel?.text = "\(element)"
            
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext:{[weak self] (indexPath) in
            let name = self!.names[indexPath.row]
            let mainSb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let vc = mainSb.instantiateViewController(withIdentifier: name)
            self?.navigationController?.pushViewController(vc, animated: true)
            
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