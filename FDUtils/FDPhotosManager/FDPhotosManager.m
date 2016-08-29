//
//  FDPhotosManager.m
//  FDExtension
//
//  Created by QianTuFD on 16/8/9.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDPhotosManager.h"
#import <Photos/Photos.h>

@implementation FDPhotosManager


+ (void)authorizationStatusAuthorizedHandler:(void(^)())authorizedHandler deniedHandler:(void(^)())deniedHandler {
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if(authorizedHandler) {
                    authorizedHandler();
                }
          }
        }];
    } else if (authorizationStatus == PHAuthorizationStatusAuthorized) {
        if(authorizedHandler) {
            authorizedHandler();
        }
    } else {
        if (deniedHandler) {
            deniedHandler();
        }
    }
}

//将图片保存到相册中(如果没有创建对应的相册)
+ (void)saveImage:(UIImage *)image toAlbum:(NSString *)albumName completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    [photoLibrary performChanges:^{
        //获取相册改变请求
        PHAssetCollectionChangeRequest *albumChangeRequest = [self getAssetCollectionChangeRequestWithAlbum:albumName];
        //获取相片请求
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        PHObjectPlaceholder *assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset;
        
        [albumChangeRequest addAssets:@[assetPlaceholder]];
    } completionHandler:completionHandler];
}

//通过相册名字获得相册改变请求(如果没有会创建一个并返回)
+ (PHAssetCollectionChangeRequest *)getAssetCollectionChangeRequestWithAlbum:(NSString *)albumName {
    PHAssetCollection *album = [self getAssetCollectionWithAlbum:albumName];
    PHAssetCollectionChangeRequest *albumChangeRequest;
    if (album) {
        albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
    } else {
        albumChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
    }
    return albumChangeRequest;
}


//通过相册名字获得相册(如果没有返回nil)
+ (PHAssetCollection *)getAssetCollectionWithAlbum:(NSString *)albumName {
    
    PHFetchResult *albumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *album in albumsFetchResult) {
        if ([album.localizedTitle isEqualToString:albumName]) {
            return album;
        }
    }
    return nil;
}
@end
