//
//  ViewController.swift
//  SwiftTut
//
//  Created by MILIKET on 11/17/16.
//  Copyright © 2016 Bình Anh Electonics. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Moya


class ViewController: UIViewController {

    var didSetupConstrainst = false
    var tableView: UITableView!
    var refresh: UIBarButtonItem!
    
    let identifier = "cell"
    
    
    var disposeBag = DisposeBag()
    var provider: RxMoyaProvider<GitHub>! = RxMoyaProvider<GitHub>()
    var dataSource = [User]()
    var responseStream: Observable<[User]> = Observable.just([])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllSubviews()
        view.setNeedsUpdateConstraints()
        rxBind()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func updateViewConstraints() {
        guard !didSetupConstrainst else {
            super.updateViewConstraints()
            return
        }
        
        setupAllConstraints()
        didSetupConstrainst = true
        super.updateViewConstraints()
    }

}


extension ViewController {
    func refresh(_ sender: UIBarButtonItem) {
        
    }
    
    func rxBind() {
        
        let requestStream: Observable<Int> = refresh.rx.tap.startWith(())
            .map { _ in
                Array(1...1000).random()
        }
        
        responseStream = requestStream
            .flatMap{ since in
                UserModel(provider: self.provider).findUsers(since: since)
        }
    }
}


extension ViewController {
    fileprivate func setupAllSubviews() {
        
        UIApplication.shared.statusBarStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = false
        title = "Home"
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blue,
                                                                   NSFontAttributeName : UIFont.systemFont(ofSize: 17)]
        setupBarButton()
        tableView = setupTableView()
        view.addSubview(tableView)
    }
    
    fileprivate func setupAllConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    fileprivate func setupTableView() -> UITableView {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(FollowTableViewCell.self, forCellReuseIdentifier: identifier)
        return table
    }
    
    fileprivate func setupBarButton() {
        refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh(_:)))
        navigationItem.rightBarButtonItem = refresh
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FollowTableViewCell
        configCell(cell, with: indexPath)
        return cell
    }
    
    func configCell(_ cell: FollowTableViewCell, with indexPath: IndexPath) {
        if indexPath.row == 4 {
            cell.seperatorRightPadding = 0
            cell.seperatorStyle = .padding(0)
            
        } else {
            cell.seperatorRightPadding = 15
            cell.seperatorStyle = .padding(15)
        }
                
        let closeStream = cell.cancel.rx.tap.startWith(())
        
        let userStream: Observable<User?> = Observable.combineLatest(
            closeStream,
            responseStream
            
        ) { (_, users) in
            guard users.count > 0 else {return nil}
            return users.random()
        }
        
        let nilOnRefreshTapStream: Observable<User?> = refresh.rx.tap.map {_ in return nil}
        let suggestionStream = Observable.of(userStream, nilOnRefreshTapStream)
            .merge()
            .startWith(.none)
        
        suggestionStream
            .subscribe(
                onNext: { (op) in
                    guard let u = op else { return self.clearCell(cell: cell) }
                    return self.setCell(cell: cell, user: u )
            },
            onError: nil,
            onCompleted: nil,
            onDisposed: nil)
            .addDisposableTo(cell.disposeBagCell)
    }
    
    func clearCell(cell: FollowTableViewCell) {
        cell.cancel.isHidden = true
        cell.avatar.image = nil
        cell.name.text = nil
    }
    
    func setCell(cell: FollowTableViewCell, user: User) {
        clearCell(cell: cell)
        guard let url = URL(string: user.avatarUrl) else {return}
        
        DispatchQueue
//            .global(priority: .default)
            .global()
            .async {
            guard let data = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async(execute: {
                cell.cancel.isHidden = false
                cell.avatar.image = UIImage(data: data)
                cell.name.text = "\(user.id) - " + user.name + "\n(\(url.description))"
            })
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}












