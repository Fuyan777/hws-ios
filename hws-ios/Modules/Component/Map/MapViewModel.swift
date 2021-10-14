//
//  MapViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/24.
//

import MapKit
import RxRelay
import RxSwift
import UIKit

class MapViewModel: NSObject {
    let spaceData = PublishRelay<[GetSpacesQuery.Data.Space]>()
    let alertError = PublishRelay<Error>()

    private let model: MapModel
    private let disposeBag = DisposeBag()

    init(model: MapModel) {
        self.model = model
        super.init()
        bindModel()
    }

    func loadMapView() {
        model.getSpace()
    }

    // MARK: Map

    func setupAllMapView(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        setupMapCoordinate(mapView: mapView, coordinate: coordinate)
        annotationPin(mapView: mapView, title: "やほー", coordinate: coordinate)
    }

    func setupMapCoordinate(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1
        )
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.region = region
    }

    func annotationPin(mapView: MKMapView, title: String, subTitle: String = "", coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.title = title
        pin.subtitle = subTitle
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }

    func bindModel() {
        model.requestSuccess.asObservable().subscribe(onNext: { [weak self] response in
            self?.spaceData.accept(response)
        }).disposed(by: disposeBag)

        model.requestError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError.accept(error)
        }).disposed(by: disposeBag)
    }
}

extension MapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // TODO: 後ほど
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default: break
        }
    }
}
