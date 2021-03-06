//
//  SFLibraryImage.h
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFImageCollectorConstants.h"

@interface SFLibraryImage : NSObject

+ (void)allImagesWithCompletionBlock:(ImageCollectionCompletionBlock)completionBlock;

@end
