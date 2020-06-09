//
//  BandDetailsViewController.swift
//  PopularBands
//
//  Created by Software Station on 09.06.2020.
//  Copyright © 2020 VadimShoshin. All rights reserved.
//

import UIKit

class BandDetailsViewController: UIViewController {

    var router: NavigationRouter!
    var viewModel: BandDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("selectedBandID - \(viewModel.bandName())")
    }
    
    func configure(router: NavigationRouter, viewModel: BandDetailsViewModel) {
        self.router = router
        self.viewModel = viewModel
    }
}
