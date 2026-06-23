#import "IOSAlarms.h"
#import <UserNotifications/UserNotifications.h>

@implementation IOSAlarms

+ (void)setAlarm:(NSString *)id title:(NSString *)title body:(NSString *)body seconds:(double)seconds {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = body;
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:id content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}

+ (void)cancelAllAlarms {
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
}

@end

extern "C" void iostools_management_set_alarm(const char *id, const char *title, const char *body, double seconds) {
    [IOSAlarms setAlarm:[NSString stringWithUTF8String:id] 
                  title:[NSString stringWithUTF8String:title] 
                   body:[NSString stringWithUTF8String:body] 
                seconds:seconds];
}

extern "C" void iostools_management_cancel_alarms() {
    [IOSAlarms cancelAllAlarms];
}
