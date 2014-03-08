//
//  NMLocationManager.h
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface NMLocationManager : NSObject <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
