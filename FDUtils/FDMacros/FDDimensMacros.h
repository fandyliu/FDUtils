//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAV_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAV_HEIGHT ((STATUS_BAR_HEIGHT) + (NAV_BAR_HEIGHT))

//屏幕 rect
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

#define SCREEN_SIZE (SCREEN_BOUNDS.size)

#define SCREEN_WIDTH (SCREEN_SIZE.width)

#define SCREEN_HEIGHT (SCREEN_SIZE.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - STATUS_AND_NAV_HEIGHT)

#define SCREEN_SCALE ([UIScreen mainScreen].scale)
//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * SCREEN_SCALE)
