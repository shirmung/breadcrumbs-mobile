//
//  Location.m
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/25/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize latitude, longitude;

- (id)init 
{
    if (self = [super init]) {
//        latitude = [NSNumber numberWithFloat:0.0];
//        longitude = [NSNumber numberWithFloat:0.0];
    }
    
    return self;
}

- (void)dealloc
{
    [latitude release];
    [longitude release];
    
    [super dealloc];
}

@end
