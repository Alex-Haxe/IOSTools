#import <UIKit/UIKit.h>
#include "IOSAlert.h"

namespace iosalert {
    void showAlert(const char* title, const char* message, const char* buttonText) {
        NSString* reqTitle = [NSString stringWithUTF8String:title];
        NSString* reqMessage = [NSString stringWithUTF8String:message];
        NSString* reqButton = [NSString stringWithUTF8String:buttonText];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:reqTitle
                                                                           message:reqMessage
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:reqButton
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil];
            
            [alert addAction:defaultAction];
            
            UIViewController* rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            while (rootVC.presentedViewController) {
                rootVC = rootVC.presentedViewController;
            }
            [rootVC presentViewController:alert animated:YES completion:nil];
        });
    }
}
