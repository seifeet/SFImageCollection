//
//  SFDetailViewController.m
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#import "SFDetailViewController.h"
#import "SFLibraryImageHelper.h"

static NSString *const kSFConstImageURLKey = @"imageURL";

@interface SFDetailViewController ()

@end

@implementation SFDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(id)newItem
{
    if (_item != newItem) {
        _item = newItem;

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.item)
    {
        NSString *urlStr = [self.item valueForKey:kSFConstImageURLKey];
        NSURL *url = [NSURL URLWithString:urlStr];

        [SFLibraryImageHelper imageDataFromURL:url completionBlock:^(NSData *imageData, NSString *imageName, NSError *error)
         {
             //NSNumber *imageRating = [NSNumber numberWithInt:(arc4random() % 100)];

             if (imageData) {

                 self.imageView.image = [UIImage imageWithData:imageData];
             } else {

             }
         }];
    }
}

@end
