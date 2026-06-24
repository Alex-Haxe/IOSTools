#import <Foundation/Foundation.h>

@interface IOSAlarms : NSObject
+ (void)setAlarm:(NSString *)id title:(NSString *)title body:(NSString *)body seconds:(double)seconds;
+ (void)cancelAllAlarms;
@end
