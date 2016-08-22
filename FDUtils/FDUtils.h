//
//  FDUtils.h
//  FDUtils
//
//  Created by QianTuFD on 16/8/22.
//  Copyright © 2016年 fandy. All rights reserved.
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
#import <FDUtils/<#name#>>


#else

#import "FDPhotosManager.h"
#import "FDFileManager.h"
#import "FDEncryptionManager.h"
#import "FDRSACryptionManager.h"

#endif // FDUtils




