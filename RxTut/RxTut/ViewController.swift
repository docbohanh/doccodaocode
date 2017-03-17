//
//  ViewController.swift
//  RxTut
//
//  Created by MILIKET on 3/16/17.
//  Copyright © 2017 Bình Anh Electonics. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
