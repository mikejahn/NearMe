//
//  NMBusinessListViewTableCell.h
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMBusinessListViewTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *category;

@end
