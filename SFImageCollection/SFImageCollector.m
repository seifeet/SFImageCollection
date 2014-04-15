//
//  SFImageCollector.m
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#include <AssetsLibrary/AssetsLibrary.h> 

#import "SFImageCollector.h"
#import "SFLibraryImage.h"


@implementation SFImageCollector

+ (void)imagesOfType:(SFImageType)type
     completionBlock:(ImageCollectionCompletionBlock)completionBlock
{
    [SFLibraryImage allImagesWithCompletionBlock:completionBlock];
}

@end
