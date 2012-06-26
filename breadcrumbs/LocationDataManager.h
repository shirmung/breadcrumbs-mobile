//
//  LocationManager.h
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/23/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationDataManager : NSObject
{
    NSMutableArray *locations;
}

@property (nonatomic, retain) NSMutableArray *locations;

+ (LocationDataManager *)sharedLocationDataManager;

- (void)saveLocations;

@end