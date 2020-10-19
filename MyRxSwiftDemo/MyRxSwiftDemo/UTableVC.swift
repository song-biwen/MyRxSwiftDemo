//
//  UTableVC.swift
//  MyRxSwiftDemo
//
//  Created by LongTu Qi on 2020/10/14.
//

import UIKit
import RxSwift
import RxCocoa

//歌曲结构体
struct Music {
    let name:String //歌名
    let singer:String //歌手
    
    init(name:String, singer:String) {
        self.name = name
        self.singer = singer
    }
    
}


class UTableVC: UIViewController {

    //数据
    var items = [
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
    ]
    
    //tableview对象
    let tableView = UITableView()
    //cell循环标识
    let cellReuseIdentifier = "Cell"
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        //UI初始化
        setupUI()
        
        //将数据绑定在tableview上
        Observable.just(items).bind(to: tableView.rx.items(cellIdentifier: cellReuseIdentifier)){ _,music,cell in
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
        }.disposed(by: disposeBag)
        
        //tableview点击响应
        tableView.rx.modelSelected(Music.self)
            .subscribe(onNext:{ [weak self] music in
                self?.showAlert(msg: "歌名：\(music.name) ---歌手：\(music.singer)")
            })
            .disposed(by: disposeBag)
    }
    
    //UI初始化
    func setupUI() {
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
    }

    //弹窗
    func showAlert(msg:String) {
        
        let alertVC = UIAlertController.init(title: "UTableVC", message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Done", style: .default, handler: { (doneAction) in
            
        }))
        present(alertVC, animated: true) {
            
        }
        
    }
}

extension UTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
