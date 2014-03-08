//
//  NMBusiness.h
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMBusiness : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *photo_url;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *is_closed;
@end
