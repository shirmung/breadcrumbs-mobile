//
//  LocationDetailViewController.h
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/25/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Location;

@interface LocationDetailViewController : UIViewController
{
    Location *specificLocation;
    
    MKMapView *mapView;
}

@property (nonatomic, retain) Location *specificLocation;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
