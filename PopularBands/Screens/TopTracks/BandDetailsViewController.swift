//
//  BandDetailsViewController.swift
//  PopularBands
//
//  Created by Software Station on 09.06.2020.
//  Copyright © 2020 VadimShoshin. All rights reserved.
//

import UIKit

class BandDetailsViewController: UIViewController {
    @IBOutlet private weak var tracksTableView: UITableView!
    @IBOutlet private weak var artistImage: UIImageView!
    
    var router: NavigationRouter!
    var viewModel: BandDetailsViewModel!
    
    var mediator: BandDetailsMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("selectedBandID - \(viewModel.bandName())")
        title = viewModel.bandName()
        mediator = BandDetailsMediator(tableView: tracksTableView, dataSource: viewModel)
        setupViewModelBlocks()
        viewModel.fetchData()
    }
    
    private func setupViewModelBlocks() {
        viewModel.onDataUpdated = { [weak self] in
            self?.mediator.reload()
        }
    }
    
    func configure(router: NavigationRouter, viewModel: BandDetailsViewModel) {
        self.router = router
        self.viewModel = viewModel
    }
}
