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
#import "SFLibraryImageHelper.h"

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
        if(result) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            {
                NSURL *url = (NSURL*)result.defaultRepresentation.url;

                [mutableArray addObject:url.absoluteString];

                if ([mutableArray count]==count)
                {
                    imageArray = [[NSArray alloc] initWithArray:mutableArray];
                    [self allImagesCollected:imageArray];
                }
            }
        }
    };

    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];

    void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            count = [group numberOfAssets];
            [assetGroups addObject:group];
            [group enumerateAssetsUsingBlock:assetEnumerator];
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
