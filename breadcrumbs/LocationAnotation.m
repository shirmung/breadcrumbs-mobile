//
//  LocationAnotation.m
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/26/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "LocationAnotation.h"

@implementation LocationAnnotation

@synthesize coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate 
{
    self = [super init];
    
    if (self) {
        // Initialization code here.
        coordinate = aCoordinate;
    }
    
    return self;
}

- (void)dealloc
{        
    [super dealloc];
}

@end
