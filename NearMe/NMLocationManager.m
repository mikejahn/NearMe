//
//  NMLocationManager.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMLocationManager.h"

@implementation NMLocationManager

- (id)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ( [CLLocationManager locationServicesEnabled] ) {
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 1000;
            [self.locationManager startUpdatingLocation];
        }
        
    }
    return self;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"did update location");
}

@end
