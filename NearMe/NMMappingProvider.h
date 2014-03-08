//
//  NMMappingProvider.h
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface NMMappingProvider : NSObject

+ (RKMapping *)businessMapping;
+ (RKMapping *) reviewSearchMapping;

@end
