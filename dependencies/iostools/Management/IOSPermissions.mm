#import "IOSPermissions.h"
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

@implementation IOSPermissions

+ (int)checkCameraPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) return 1;
    if (status == AVAuthorizationStatusNotDetermined) return 0;
    return -1;
}

+ (void)requestCameraPermission {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {}];
}

+ (int)checkNotificationPermission {
    __block int result = 0;
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) result = 1;
        else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) result = 0;
        else result = -1;
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    return result;
}

+ (void)requestNotificationPermission {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
}

+ (int)checkFilesPermission {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isWritableFileAtPath:documentsPath]) {
        return 1;
    }
    return -1;
}

+ (void)requestFilesPermission {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeImport];
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (rootVC) {
            [rootVC presentViewController:documentPicker animated:YES completion:nil];
        }
    });
}

@end

extern "C" int iostools_management_check_camera() {
    return [IOSPermissions checkCameraPermission];
}

extern "C" void iostools_management_request_camera() {
    [IOSPermissions requestCameraPermission];
}

extern "C" int iostools_management_check_notifications() {
    return [IOSPermissions checkNotificationPermission];
}

extern "C" void iostools_management_request_notifications() {
    [IOSPermissions requestNotificationPermission];
}

extern "C" int iostools_management_check_files() {
    return [IOSPermissions checkFilesPermission];
}

extern "C" void iostools_management_request_files() {
    [IOSPermissions requestFilesPermission];
}
