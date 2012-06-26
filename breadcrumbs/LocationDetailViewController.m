//
//  LocationDetailViewController.m
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/25/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "LocationDetailViewController.h"
#import "Location.h"
#import "LocationAnotation.h"

@interface LocationDetailViewController ()

@end

@implementation LocationDetailViewController

@synthesize specificLocation, mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void) dealloc
{
    [specificLocation release];
    [mapView release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Location Detail";
    
    CLLocationCoordinate2D coordinate; 
    coordinate.latitude = [specificLocation.latitude floatValue];
    coordinate.longitude = [specificLocation.longitude floatValue];
    
    //set span to half mile x half mile
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 0.5 * 1609.344, 0.5 * 1609.344);
    MKCoordinateRegion fittedRegion = [mapView regionThatFits:region];                
    
    [mapView setRegion:fittedRegion animated:YES];              
    
    LocationAnnotation *annotation = [[[LocationAnnotation alloc] initWithCoordinate:coordinate] autorelease];
    [mapView addAnnotation:annotation];   
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

@end
