//
//  SFLibraryImageHelper.m
//  SFImageCollection
//
//  Created by AT on 4/25/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#include <AssetsLibrary/AssetsLibrary.h> 

#import "SFLibraryImageHelper.h"

@implementation SFLibraryImageHelper

+ (void)imageDataFromURL:(NSURL *)url completionBlock:(ImageDataCompletionBlock)completionBlock
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    [library assetForURL:url
             resultBlock:^(ALAsset *asset)
     {
         ALAssetRepresentation *rep = [asset defaultRepresentation];
         Byte *buffer = (Byte*)malloc(rep.size);
         NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];

         NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];

         if (completionBlock) {

             completionBlock(data, rep.filename, nil);
         }
     }
            failureBlock:^(NSError *error)
     {
         if (completionBlock) {

             completionBlock(nil, nil, error);
         }
     }];
}

@end
