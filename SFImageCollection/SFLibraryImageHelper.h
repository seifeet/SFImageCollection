//
//  SFLibraryImageHelper.h
//  SFImageCollection
//
//  Created by AT 4/25/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SFImageCollectorConstants.h"

@interface SFLibraryImageHelper : NSObject

+ (void)imageDataFromURL:(NSURL *)url completionBlock:(ImageDataCompletionBlock)completionBlock;

@end
