// Debug or Release
#ifdef DEBUG  // Debug
#define DLog(fmt, ...)   NSLog(@"\n 🍎 类名与方法名: %s [Line %d] \n 🍏 " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define IsProduct 0

#else  // Release
#define DLog(fmt, ...)  ((void)0)
#define NSLog(fmt, ...)  ((void)0)
#define IsProduct 1
#endif


//System version utils

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//大于等于7.0的ios版本
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//大于等于8.0的ios版本
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")


// 屏幕适配

#define iPhone4x_3_5      ([UIScreen mainScreen].bounds.size.height == 480.0f)

#define iPhone5x_4_0      ([UIScreen mainScreen].bounds.size.height == 568.0f)

#define iPhone6_4_7       ([UIScreen mainScreen].bounds.size.height == 667.0f)

#define iphone6Plus_5_5   ([UIScreen mainScreen].bounds.size.height == 736.0f || [UIScreen mainScreen].bounds.size.width == 414.0f)


// 获取RGB颜色
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)     RGBA(r,g,b,1.0f)
#define RandomColor    RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


// 方向

#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

// 空
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
// weakself

#define WeakSelf     __weak typeof(self) weakSelf = self;
#define StrongSelf   __strong typeof(weakSelf) strongSelf = weakSelf;



//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)



//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
