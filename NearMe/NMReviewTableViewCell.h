//
//  NMReviewTableViewCell.h
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userThumbnailImageView;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImageView;

@end
