//
//  ShopsController.swift
//  MADShops
//
//  Created by Daniel Ruiz on 15/05/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ShopsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    let cellId = "ShopCell"
    let regionRadius: CLLocationDistance = 1000
    let madridLocation: CLLocation = CLLocation(latitude: 40.4165, longitude: -3.70256)
    
    var context = CoreDataStack.sharedInstance.context
    var cachedShops: [Shop] {
        get {
            let request: NSFetchRequest<Shop> = Shop.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.fetchBatchSize = 20
            request.sortDescriptors = [sortDescriptor]
            do {
                return try context.fetch(request)
            } catch {
                return []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        centerMapOn(location: madridLocation)
        mapView.addAnnotations(cachedShops.flatMap({ ShopAnnotation(shop: $0) }))
    }
    
    private func centerMapOn(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 10, regionRadius * 10)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}


extension ShopsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cachedShops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shop = cachedShops[indexPath.row]
        let cell: ShopCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ShopCell
        
        if let shopName = shop.name, let logoData = shop.logo?.data {
            cell.nameLabel?.text = shopName
            cell.logoView.image = UIImage(data: logoData as Data)
        }
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ShopsController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShopDetail" {
            if let indexPath = self.tableView.indexPath(for: sender as! ShopCell) {
                let controller = segue.destination as! ShopDetailController
                controller.shop = cachedShops[indexPath.row]
            }
        }
    }
    
}

extension ShopsController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ShopAnnotation else { return nil }
        
        let shopAnnotationID = "ShopAnnotationID"
        let view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: shopAnnotationID
            ) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: shopAnnotationID)
            view.image = #imageLiteral(resourceName: "Location Pin")
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        
        return view
    }
}
