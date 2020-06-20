//
//  ViewController.swift
//  CognizantTask
//
//  Created by Barath on 20/06/20.
//  Copyright © 2020 Barath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    private var results: [Row] = []
    private let canadaViewModel = CanadaViewModel()
    private let cellIdentifier = "ItemCell"
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func loadView(){
        super.loadView()
        self.setUpTableView()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.updateTablview()
        self.getServiceData()
    }
    
    func setUpTableView(){
        let safeGuide = self.view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        tableView.register(RowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.addSubview(self.refreshControl)
    }
    
    func updateTablview(){
        tableView.backgroundColor = .white
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl){
        getServiceData(true)
    }
    
    func updateTableViewData(dataModel : CanadaDataModel){
        self.results = dataModel.rows.filter({$0.imageHref != nil || $0.title != nil || $0.rowDescription != nil  })
        self.title = dataModel.title
        self.tableView.reloadData()
    }
    
    func getServiceData(_ isFromRefresh: Bool = false){
        guard Utility.isConnectedtoNetwork() else {
            if(isFromRefresh){
                refreshControl.endRefreshing()
            }
            return
        }
        isFromRefresh ? refreshControl.endRefreshing() : self.startLoading()
        self.callIngAPI(isFromRefresh: isFromRefresh, url: AppConstants.SERVICE_URL)
    }
    
    func callIngAPI(isFromRefresh: Bool, url: String){
        canadaViewModel.getCanadaDetails(url: url) {[weak self](result) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.stopLoading()
                if(isFromRefresh){
                    strongSelf.refreshControl.endRefreshing()
                }
            }
            switch result{
            case .success(let dataModel):
                DispatchQueue.main.async {
                    strongSelf.updateTableViewData(dataModel: dataModel)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RowTableViewCell
        cell.item = results[indexPath.row]
        return cell
    }
}
