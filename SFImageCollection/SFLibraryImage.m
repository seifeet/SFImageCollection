//
//  SFLibraryImage.m
//  SFImageCollection
//
//  Created by AT on 4/14/14.
//  Copyright (c) 2014 SF. All rights reserved.
//

#include <AssetsLibrary/AssetsLibrary.h> 
#include <stdlib.h>

#import "SFLibraryImage.h"

static NSString *const kSFConstImageNameKey = @"imageName";
static NSString *const kSFConstImageDataKey = @"imageData";
static NSString *const kSFConstImageRatingKey = @"imageRating";

@interface SFLibraryImage ()

@property (readwrite, copy) ImageCollectionCompletionBlock completionBlock;

@end

@implementation SFLibraryImage

+ (void)allImagesWithCompletionBlock:(ImageCollectionCompletionBlock)completionBlock
{
    SFLibraryImage *libraryImage = [[SFLibraryImage alloc] init];

    [libraryImage getAllImagesWithCompletionBlock:completionBlock];
}

- (void)getAllImagesWithCompletionBlock:(ImageCollectionCompletionBlock)completionBlock
{
    self.completionBlock = completionBlock;

    __block NSArray *imageArray=[[NSArray alloc] init];
    __block NSMutableArray *mutableArray =[[NSMutableArray alloc]init];

    __block NSInteger count = 0;

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop)
    {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            {
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];

                [library assetForURL:url
                         resultBlock:^(ALAsset *asset)
                 {
                     ALAssetRepresentation *rep = [asset defaultRepresentation];
                     Byte *buffer = (Byte*)malloc(rep.size);
                     NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];

                     NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                     NSNumber *imageRating = [NSNumber numberWithInt:(arc4random() % 100)];
                     NSString *imageName = [rep filename];

                     NSDictionary *imageParams = @{ kSFConstImageDataKey : data,
                                                    kSFConstImageNameKey : imageName,
                                                    kSFConstImageRatingKey : imageRating };

                     [mutableArray addObject:imageParams];

                     if ([mutableArray count]==count)
                     {
                         imageArray = [[NSArray alloc] initWithArray:mutableArray];
                         [self allImagesCollected:imageArray];
                     }
                 }
                        failureBlock:^(NSError *error)
                 {
                     [self processError:error];
                 }];

            }
        }
    };

    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];

    void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error)
    {
        [self processError:error];
    }];
}

- (void)allImagesCollected:(NSArray *)imgArray
{
    NSLog(@"Image collection Success: %lu",(unsigned long)imgArray.count);

    if (self.completionBlock) {

        self.completionBlock(imgArray, nil);
    }
}

- (void)processError:(NSError *)error
{
    NSLog(@"Image collection Failure: %@", error.localizedDescription);

    if (self.completionBlock) {

        self.completionBlock(nil, error);
    }

}

@end
