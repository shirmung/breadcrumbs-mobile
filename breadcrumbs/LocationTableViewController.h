//
//  LocationTableViewController.h
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/25/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate> 
{
    UITableView *locationsTableView;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet UITableView *locationsTableView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
