//
//  ViewController.swift
//  RxTut
//
//  Created by MILIKET on 3/16/17.
//  Copyright © 2017 Bình Anh Electonics. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var tableView: UITableView!
    
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 17.03.2017 - RxTraining
        ///
        /// 1. Đối tượng chính: stream
        /// 1.1 `Observable - obs` - là stream, tạm dịch là có thể quan sát được,
        /// có thể hiểu luồng cần thực thi như một ống nước thì obs là dòng nước chảy trong ống nước đó
        /// 1.2 `DisposeBag` - hiểu như một cái sọt rác, nghĩa là sau khi stream chạy xong cần giải phóng bộ nhớ thì bỏ vào đây
        ///
        /// 2. Khởi tạo: *create, deferred, empty, never, of (from), interval, *just, range
        /// VD:
        Observable<Int>.create { obs in //Khởi tạo một stream kiểu `Int`
            // Thêm event: onNext, onError, onCompleted
            obs.onNext(1) // Thêm số 1 vào stream hiện tại
            obs.onNext(2)
            obs.onCompleted() // Thông báo kết thúc, những event viết sau dòng này thì ko được thêm vào stream
            
            obs.onNext(3)
            
            // Nhả ra một stream ?
            return Disposables.create()
            }
            // Xử lý stream
            .subscribe (
                onNext: { print($0) }
            )
            // Xử lý xong thì di chết nó để giải phóng bộ nhớ bằng cách ném vào `bag`
            .addDisposableTo(bag)
        
        /// Kết quả in ra: 1, 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: DELEGATE
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
}

//MARK: SETUP
extension ViewController {
    func setupAllSubviews() {
        
    }
    
    func setupAllConstraints() {
        
    }
    
    func setupTable() -> UITableView {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        return table
    }
    
}
