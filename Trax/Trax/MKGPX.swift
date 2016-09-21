//
//  MKGPX.swift
//  Trax
//

import MapKit

class EditableWaypoint : GPX.Waypoint {
    override var coordinate: CLLocationCoordinate2D {
        get {
            return super.coordinate
        } set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
}

extension GPX.Waypoint : MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? { return name }
    
    var subtitle: String? { return info }
    
    var thumbnailURL : URL? {
        return getImageURLofType(type: "thumbnail")
    }
    
    var imageURL: URL? {
        return getImageURLofType(type: "large")
    }

    private func getImageURLofType(type: String?) -> URL? {
        for link in links {
            if link.type == type {
                return link.url
            }
        }
        return nil
    }
}
