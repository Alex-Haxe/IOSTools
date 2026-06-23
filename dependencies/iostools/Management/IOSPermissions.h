#import <Foundation/Foundation.h>

@interface IOSPermissions : NSObject
+ (int)checkCameraPermission;
+ (void)requestCameraPermission;
+ (int)checkNotificationPermission;
+ (void)requestNotificationPermission;
+ (int)checkFilesPermission;
+ (void)requestFilesPermission;
@end
