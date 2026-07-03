#ifndef IOS_ALERT_H
#define IOS_ALERT_H

#import <UIKit/UIKit.h>

@interface IOSAlertNative : NSObject

+ (void)showAlert:(NSString *)title
          message:(NSString *)message
       buttonText:(NSString *)buttonText;

@end

#endif
