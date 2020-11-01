//
//  ViewController.swift
//  Demo
//
//  Created by 高涌 on 2020/11/1.
//

import UIKit

class MainViewController: UIViewController {
    struct constants {
        static let kCellNibName = "ResultTableViewCell"
    }

    private lazy var viewModel: MainPageViewModel = MainPageViewModelFactory.createMainPageViewModel(aDelegate: self)
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.

    }
    
    func setupUI() {
        tableView.register(UINib.init(nibName: constants.kCellNibName, bundle: nil), forCellReuseIdentifier: constants.kCellNibName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startRegularRefresh()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopRegularRefresh()
    }


}

extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.kCellNibName) as! ResultTableViewCell
        if let result = viewModel.resultFor(indexpath: indexPath) {
            cell.configCellWith(data: result)
        }
        return cell
    }
}

extension MainViewController:MainPageViewModelDelegate{
    func fetchWithError(error: NSError) {
        //show error
    }
    
    func fetchSuccess() {
        tableView.reloadData()
    }
    
}

