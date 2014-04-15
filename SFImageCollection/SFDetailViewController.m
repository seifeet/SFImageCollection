//
//  SFDetailViewController.m
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#import "SFDetailViewController.h"

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
        self.imageView.image = [UIImage imageWithData:[self.item valueForKey:@"imageData"]];
        self.title = [self.item valueForKey:@"imageName"];
    }
}

@end
