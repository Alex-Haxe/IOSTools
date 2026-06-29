#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#include <hx/CFFI.h>
#include "IOSNotifications.h"

namespace ios_notifications {

    void request_permission() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
            [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
        });
    }

    void send_notification(const char* title, const char* body) {
        NSString *nsTitle = [NSString stringWithUTF8String:title];
        NSString *nsBody = [NSString stringWithUTF8String:body];

        dispatch_async(dispatch_get_main_queue(), ^{
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            content.title = nsTitle;
            content.body = nsBody;
            content.sound = [UNNotificationSound defaultSound];

            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
            NSString *identifier = [[NSUUID UUID] UUIDString];
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];

            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {}];
        });
    }
}

extern "C" void ios_notifications_request_permission() {
    ios_notifications::request_permission();
}
DEFINE_PRIME1(ios_notifications_request_permission);

extern "C" void ios_notifications_send_notification(value title, value body) {
    ios_notifications::send_notification(val_string(title), val_string(body));
}
DEFINE_PRIME1(ios_notifications_send_notification);
