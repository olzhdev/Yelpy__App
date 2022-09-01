//
//  Extensions.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit
import MapKit

extension UIView {
    
    /// Adds multiple subviews
    /// - Parameter views: Collection of subviews
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}


extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
}


extension String {
    
    /// Return attributed string
    /// - Parameter text: String text for bold text.
    func getAttributedBoldText(text: String) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: self, attributes: [.foregroundColor: UIColor.secondaryLabel])
        
        if let range = self.range(of: text) {
            let startIndex = self.distance(from: self.startIndex, to: range.lowerBound)
            let range = NSMakeRange(startIndex, text.count)
            attributedString.addAttributes([.font : UIFont.boldSystemFont(ofSize: 17)], range: range)
        }
        return attributedString
    }
}


extension MKMapView {
    
    /// Centers map and zoomes map to given coordinates
    /// - Parameters:
    ///   - location: Coordinates
    ///   - regionRadius: Zoom parameter
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: false)
    }
}
