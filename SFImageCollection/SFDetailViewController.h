//
//  SFDetailViewController.h
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFDetailViewController : UIViewController

@property (strong, nonatomic) id item;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
