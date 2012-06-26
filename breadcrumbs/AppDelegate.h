//
//  AppDelegate.h
//  breadcrumbs
//
//  Created by Shirmung Bielefeld on 6/23/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LocationTableViewController *locationTableViewController;
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@end
