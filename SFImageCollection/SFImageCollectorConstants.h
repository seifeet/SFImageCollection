//
//  SFImageCollectorConstants.h
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    SFImageTypeLibrary = 0,
    SFImageTypeFlickr
} SFImageType;

typedef void (^ImageCollectionCompletionBlock)(NSArray *images, NSError *error);
