#define FDSingletonH(name) + (instancetype)share##name;

//在ARC中
#if __has_feature(objc_arc)

#define FDSingletonM(name)\
static id _instance = nil;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)share##name\
{\
return [[self alloc] init];\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#else
//MRC环境
#define FDSingletonM(name)\
static id _instance = nil;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)share##name\
{\
return [[self alloc] init];\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
- (oneway void)release\
{}\
- (instancetype)retain\
{\
return _instance;\
}\
\
- (NSUInteger)retainCount\
{\
return MAXFLOAT;\
}

#endif
