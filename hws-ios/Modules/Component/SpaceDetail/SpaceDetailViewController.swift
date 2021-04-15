//
//  SpaceDetailViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            let nibs = [
                CategoryTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }
    
    @IBOutlet weak var goSpaceButton: UIButton!
    
    private let viewModel: SpaceDetailViewModel
    
    init(viewModel: SpaceDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}