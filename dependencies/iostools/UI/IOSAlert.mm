#import <UIKit/UIKit.h>
#include <hx/CFFI.h>
#include <hx/CFFIPrime.h>
#include "IOSAlert.h"

@interface IOSAlertNative : NSObject
+ (void)showAlert:(NSString*)title message:(NSString*)message buttonText:(NSString*)buttonText;
@end

@implementation IOSAlertNative

+ (void)showAlert:(NSString*)title message:(NSString*)message buttonText:(NSString*)buttonText {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:buttonText
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alert addAction:defaultAction];

        UIViewController *rootVC = nil;

        if (@available(iOS 13.0, *)) {
            for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive &&
                    [scene isKindOfClass:[UIWindowScene class]]) {
                    UIWindowScene *windowScene = (UIWindowScene *)scene;
                    for (UIWindow *window in windowScene.windows) {
                        if (window.isKeyWindow) {
                            rootVC = window.rootViewController;
                            break;
                        }
                    }
                    if (rootVC != nil) break;
                }
            }
        }

        if (rootVC == nil) {
            rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        }

        while (rootVC.presentedViewController) {
            rootVC = rootVC.presentedViewController;
        }

        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

@end

extern "C" value ios_show_native_alert(value title, value message, value buttonText) {
    NSString *nsTitle = [NSString stringWithUTF8String:val_string(title)];
    NSString *nsMessage = [NSString stringWithUTF8String:val_string(message)];
    NSString *nsButton = [NSString stringWithUTF8String:val_string(buttonText)];

    [IOSAlertNative showAlert:nsTitle message:nsMessage buttonText:nsButton];
    return alloc_null();
}

DEFINE_PRIME3(ios_show_native_alert);
