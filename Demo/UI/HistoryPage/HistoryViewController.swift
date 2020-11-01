//
//  HistoryViewController.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

class HistoryViewController: UIViewController  {
    struct constants {
        static let kCellNibName = "HistoryTableViewCell"
    }

    
    private lazy var viewModel: HistoryViewModel = HistoryViewModelFactory.createHisotryViewModel(aDelegate: self)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadHistory()
    }
    
    func setupUI() {
        tableView.register(UINib.init(nibName: constants.kCellNibName, bundle: nil), forCellReuseIdentifier: constants.kCellNibName)
    }

}

extension HistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHistory()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.kCellNibName) as! HistoryTableViewCell
        if let result = viewModel.resultFor(indexpath: indexPath) {
            cell.configCellWith(data: result)
        }
        return cell
    }
    
    
}

extension HistoryViewController: HistoryViewModelDelegate{
    func fetchWithError(error: NSError) {
        //show error
    }
    
    func fetchSuccess() {
        tableView.reloadData()
    }
    
    
}
