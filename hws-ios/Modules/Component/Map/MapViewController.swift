//
//  MapViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/24.
//

import MapKit
import RxSwift
import UIKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView! {
        didSet { mapView.delegate = viewModel }
    }

    private let viewModel: MapViewModel
    private let disposeBag = DisposeBag()
    var locationManager: CLLocationManager! = CLLocationManager()

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
        locationManager.delegate = viewModel
        // 東京駅の位置情報をセット
        let tokyoStation = CLLocationCoordinate2DMake(41.7687, 140.7288)
        //        let coordinate = mapView.userLocation.coordinate
        bindViewModel()
        viewModel.setupAllMapView(mapView: mapView, coordinate: tokyoStation)
        viewModel.loadMapView()
    }

    func bindViewModel() {
        viewModel.alertError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError(error: error)
        }).disposed(by: disposeBag)

        viewModel.spaceData.asObservable().subscribe(onNext: { [weak self] spaceData in
            spaceData.forEach { response in
                self?.viewModel.annotationPin(
                    mapView: self?.mapView ?? MKMapView(),
                    title: response.name,
                    coordinate: CLLocationCoordinate2DMake(response.longitude ?? 0.0, response.latitude ?? 0.0)
                )
            }
        }).disposed(by: disposeBag)
    }
}
