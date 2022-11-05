//
//  GoogleMapsViewController.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 10.10.2022.
//

import UIKit
import GoogleMaps

class GoogleMapsViewController: UIViewController {
    
    private let googleMap: GMSMapView = {
        let camera = GMSCameraPosition.camera(
            withLatitude: Constants.googleMapDefaultLatitude,
            longitude: Constants.googleMapDefaultLongtitude,
            zoom: Constants.googleMapDefaultZoom)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.mapType = .normal
        mapView.isIndoorEnabled = false
        return mapView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.separatorStyle = .none
        tableView.register(GoogleMapsTableViewCell.self, forCellReuseIdentifier: GoogleMapsTableViewCell.identifier)
        return tableView
    }()
    
    var launchPads = [LaunchPadModel]()
    var landingPads = [LandingPadModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(googleMap)
        view.addSubview(tableView)
        
        launchPads = DIContainer.shared.networkManager.launchPads
        for launchPad in launchPads {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: launchPad.latitude, longitude: launchPad.longitude)
            marker.title = launchPad.locality
            marker.snippet = launchPad.region
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.map = googleMap
        }
        
        landingPads = DIContainer.shared.networkManager.landingPads
        for landingPad in landingPads {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: landingPad.latitude, longitude: landingPad.longitude)
            marker.title = landingPad.locality
            marker.snippet = landingPad.region
            marker.icon = GMSMarker.markerImage(with: .blue)
            marker.map = googleMap
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        googleMap.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(
            NSLayoutConstraint(item: tableView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view.safeAreaLayoutGuide,
                               attribute: .bottom,
                               multiplier: Constants.googleMapTableViewMultiplier,
                               constant: Constants.googleMapTableViewConstant)
        )
        view.addConstraint(
            NSLayoutConstraint(item: tableView,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leading,
                               multiplier: Constants.googleMapTableViewMultiplier,
                               constant: Constants.googleMapTableViewConstant)
        )
        view.addConstraint(
            NSLayoutConstraint(item: tableView,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: Constants.googleMapTableViewMultiplier,
                               constant: Constants.googleMapTableViewConstant)
        )
        view.addConstraint(
            NSLayoutConstraint(item: tableView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .top,
                               multiplier: Constants.googleMapTableViewMultiplier,
                               constant: view.frame.height / 2)
        )
        view.addConstraint(
            NSLayoutConstraint(item: googleMap,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .bottom,
                               multiplier: Constants.googleMapMultiplier,
                               constant: -(view.frame.height / 2))
        )
        view.addConstraint(
            NSLayoutConstraint(item: googleMap,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leading,
                               multiplier: Constants.googleMapMultiplier,
                               constant: Constants.googleMapConstant)
        )
        view.addConstraint(
            NSLayoutConstraint(item: googleMap,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: Constants.googleMapMultiplier,
                               constant: Constants.googleMapConstant)
        )
        view.addConstraint(
            NSLayoutConstraint(item: googleMap,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: view.safeAreaLayoutGuide,
                               attribute: .top,
                               multiplier: Constants.googleMapMultiplier,
                               constant: Constants.googleMapConstant)
        )
    }
}

extension GoogleMapsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0: let animation = GMSCameraPosition.camera(withLatitude: launchPads[indexPath.row].latitude, longitude: launchPads[indexPath.row].longitude, zoom: Constants.googleMapZoomWhenSelectTableCell)
            googleMap.animate(to: animation)
        case 1: let animation = GMSCameraPosition.camera(withLatitude: landingPads[indexPath.row].latitude, longitude: landingPads[indexPath.row].longitude, zoom: Constants.googleMapZoomWhenSelectTableCell)
            googleMap.animate(to: animation)
        default: print("row selected, but wrong section")
        }
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var text = String()
        switch section {
        case 0: text = Texts.googleMapLaunchPads
        case 1: text = Texts.googleMapLandingPads
        default: print("title problem")
        }
        return text
    }
}

extension GoogleMapsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launchPads.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoogleMapsTableViewCell.identifier, for: indexPath) as? GoogleMapsTableViewCell else { fatalError("Problem GoogleMapsTableViewCell") }
        switch indexPath.section {
        case 0: cell.configure(text: launchPads[indexPath.row].fullName)
        case 1: cell.configure(text: landingPads[indexPath.row].fullName)
        default: print("default in GM VC")
        }
        return cell
    }
}
