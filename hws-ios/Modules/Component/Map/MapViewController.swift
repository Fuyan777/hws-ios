//
//  MapViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/24.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    private let viewModel: MapViewModel

    init(viewModel: MapViewModel) {
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
