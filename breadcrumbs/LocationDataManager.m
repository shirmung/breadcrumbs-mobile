//
//  LocationManager.m
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/23/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "LocationDataManager.h"
#import "Location.h"

@implementation LocationDataManager

@synthesize locations;

static LocationDataManager *sharedLocationDataManager;

+ (LocationDataManager *)sharedLocationDataManager
{
	if (sharedLocationDataManager == nil) {
        sharedLocationDataManager = [[LocationDataManager alloc] init];
	}	
	
	return sharedLocationDataManager;
}	

- (id)init
{
    if (self = [super init]) {
        locations = [[NSMutableArray alloc] init];
        
        NSString *locationsDataFilePath = [NSString stringWithString:[self locationsDataFilePath]];
        BOOL locationsFileExists = [[NSFileManager defaultManager] fileExistsAtPath:locationsDataFilePath];
        
        if (locationsFileExists) {
            NSDictionary *locationsData = [NSDictionary dictionaryWithContentsOfFile:locationsDataFilePath];
                        
            for (NSString *locationKey in locationsData) {
                NSDictionary *detailsOfLocation = [locationsData objectForKey:locationKey];
                
                Location *location = [[Location alloc] init];
                
                location.latitude = [detailsOfLocation objectForKey:@"latitude"];
                location.longitude = [detailsOfLocation objectForKey:@"longitude"];
                
                [locations addObject:location];
                
                [location release];
            }
        }
    }
    
    return self;
}

- (void)dealloc
{
    [locations release];
    
    [super dealloc];
}

- (void)saveLocations
{    
    NSMutableDictionary *locationsData = [[NSMutableDictionary alloc] init];
    
    for (Location *location in locations) {
        NSMutableDictionary *detailsOfLocation = [[NSMutableDictionary alloc] init];
        
        [detailsOfLocation setObject:location.latitude forKey:@"latitude"];
        [detailsOfLocation setObject:location.longitude forKey:@"longitude"];
        
        [locationsData setObject:detailsOfLocation forKey:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]]];
        
        [detailsOfLocation release];
    }
    
    [locationsData writeToFile:[self locationsDataFilePath] atomically:YES];
    
    [locationsData release];
}

- (NSString *)locationsDataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:@"userLocationsData.plist"];
}

@end
