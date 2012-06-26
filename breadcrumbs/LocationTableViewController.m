//
//  LocationTableViewController.m
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/25/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "LocationTableViewController.h"
#import "LocationDataManager.h"
#import "Location.h"
#import "LocationDetailViewController.h"

@interface LocationTableViewController ()

@end

@implementation LocationTableViewController

@synthesize locationsTableView, locationManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)dealloc 
{
    [locationsTableView release];
    [locationManager release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Locations";
        
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Location methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation];
    
    float latitudeDegrees = newLocation.coordinate.latitude;
    float longitudeDegrees = newLocation.coordinate.longitude;
    
    Location *location = [[Location alloc] init];
    location.latitude = [NSNumber numberWithFloat:latitudeDegrees];
    location.longitude = [NSNumber numberWithFloat:longitudeDegrees];
    
    [[LocationDataManager sharedLocationDataManager].locations addObject:location];
    [[LocationDataManager sharedLocationDataManager] saveLocations];
    
    [locationsTableView reloadData];
    
    // this should happen asynchronously INSTEAD
    NSDictionary *innerDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%f", longitudeDegrees], @"longitude", [NSString stringWithFormat:@"%f", latitudeDegrees], @"latitude", [[NSUserDefaults standardUserDefaults] stringForKey:@"uniqueID"], @"unique_id", nil];
    NSDictionary *outerDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:innerDictionary, @"location", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:outerDictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://breadcrumbs-ios.herokuapp.com/locations"] 
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
                                                       timeoutInterval:60.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = jsonData;
        
    NSData *requestData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSString *get = [[NSString alloc] initWithData: requestData encoding: NSUTF8StringEncoding];
    NSLog(@">%@<",get);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LocationDataManager sharedLocationDataManager].locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Location *specificLocation = [[LocationDataManager sharedLocationDataManager].locations objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%f, %f", [specificLocation.latitude floatValue], [specificLocation.longitude floatValue]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *location = [[LocationDataManager sharedLocationDataManager].locations objectAtIndex:[indexPath row]];
    
    LocationDetailViewController *locationDetailViewController = [[LocationDetailViewController alloc] init];
    locationDetailViewController.specificLocation = location;
    
    [self.navigationController pushViewController:locationDetailViewController animated:YES];
    
    [locationDetailViewController release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Button methods

- (IBAction)updateLocation:(UIBarButtonItem *)barButtonItem
{
    [locationManager startUpdatingLocation];
}

@end