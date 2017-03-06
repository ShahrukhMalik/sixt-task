//
//  SXMainViewController.swift
//  Sixt
//
//  Created by Shahrukh on 22/12/2016.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit
import MapKit

class SXMainViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var cars: [SXCarInfo]? = nil
    
    var refreshControl: UIRefreshControl!
    
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cars"
        
        // Register custom cell nib
        self.tableView.register(UINib.init(nibName: "SXCarTableViewCell", bundle: nil), forCellReuseIdentifier: "SXCarTableViewCellIdentifier")
        
        // Remove extra separators at the end of table view
        self.tableView.tableFooterView = UIView()
        
        // For full width separators
        self.tableView.separatorInset = .zero
        self.tableView.layoutMargins = .zero
        
        // Send web service request
        sendCarsRequest()
        
        // Pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SXMainViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.cars?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SXCarTableViewCellIdentifier", for: indexPath) as! SXCarTableViewCell
        cell.selectionStyle = .none
        
        // Fetching car object
        let car: SXCarInfo = (cars?[indexPath.row])!
        
        // Populating cell with car data
        cell.modelNameLabel.text = (car.modelName)!
        cell.makeLabel.text = (car.make)!
        cell.ownerNameLabel.text = (car.name)!
        cell.licensePlateLabel.text = (car.licensePlate)!
        cell.colorLabel.text = (car.formattedColorString)!
        cell.fuelTypeLabel.text = (car.formattedFuelTypeString)!
        cell.fuelLevelLabel.text = (car.formattedFuelLevelString)!
        cell.transmissionLabel.text = (car.formattedTransmissionString)!
        cell.cleanlinessLabel.text = (car.formattedCleanlinessString)!
        
        // Update car image
        let url = URL(string: (car.carImageUrl)!)
        cell.carImageView?.kf.setImage(with: url)
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath: IndexPath) -> CGFloat {
        return 259.0
    }
    
    
    // MARK: - Action methods
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            
            // List
            self.mapView.isHidden = true
            self.tableView.isHidden = false
            
        } else if self.segmentedControl.selectedSegmentIndex == 1 {
            
            // Map
            self.mapView.isHidden = false
            self.tableView.isHidden = true
        }
    }
    
    func refresh() {
        self.sendCarsRequest()
        self.refreshControl.endRefreshing()
    }
    
    
    // MARK: - Private methods
    
    private func sendCarsRequest() {
        
        // Send web service request
        SXAPIClient.sharedClient.sendCarsInfoRequestWithCompletion { (success, res, error) in
            
            if (success) {
                
                if let arr = res as? NSArray {
                    self.cars = SXCarInfo.arrayOfCarInfoObjectsFromInfoArray(infoArray: arr)
                    self.tableView.reloadData()
                    self.plotCarsOnMap()
                }
                
            } else {
                
                // Error handling
                let alertController = UIAlertController(title: "Error", message: (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true)
            }
        }
    }
    
    private func plotCarsOnMap() {
        var annotations = [MKPointAnnotation]()
        
        if (cars?.count)! > 0 {
            
            // Focus map on location of first car
            let firstCar: SXCarInfo = cars![0]
            let initialLocation = CLLocation(latitude: firstCar.latitude, longitude: firstCar.longitude)
            self.centerMapOnLocation(loc: initialLocation)
            
            // Plot cars coordinates on map
            for car in cars! {
                let ann: MKPointAnnotation = MKPointAnnotation()
                ann.coordinate = CLLocationCoordinate2DMake(car.latitude, car.longitude)
                ann.title = (car.licensePlate)!
                annotations.append(ann)
            }
        }
        
        self.mapView.addAnnotations(annotations)
    }
    
    private func centerMapOnLocation(loc: CLLocation) {
        let regionRadius: CLLocationDistance = 1000 // 1000 meters
        
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate, regionRadius*10, regionRadius*10)
        self.mapView.setRegion(region, animated: true)
    }
}
