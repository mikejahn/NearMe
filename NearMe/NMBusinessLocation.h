//
//  NMBusinessLocation.h
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NMBusiness.h"


@interface NMBusinessLocation : NSObject <MKAnnotation>{
    
    NSString *title;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, assign)NMBusiness *business;


@end
