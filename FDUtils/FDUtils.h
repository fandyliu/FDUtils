//
//  FDUtils.h
//  FDUtils
//
//  Created by fandy on 15/8/22.
//  Copyright © 2015年 fandy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FDFileManager.h"

FOUNDATION_EXPORT double FDUtilsVersionNumber;

FOUNDATION_EXPORT const unsigned char FDUtilsVersionString[];


#if __has_include(<FDUtils/FDUtils.h>)


#import <FDUtils/FDPhotosManager.h>
#import <FDUtils/FDFileManager.h>
#import <FDUtils/FDEncryptionManager.h>
#import <FDUtils/FDRSACryptionManager.h>
#import <FDUtils/FDTripleDESMananger.h>


#else

#import "FDPhotosManager.h"
#import "FDFileManager.h"
#import "FDEncryptionManager.h"
#import "FDRSACryptionManager.h"
#import "FDTripleDESMananger.h"

#endif // FDUtils




