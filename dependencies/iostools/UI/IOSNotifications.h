#ifndef IOS_NOTIFICATIONS_H
#define IOS_NOTIFICATIONS_H

namespace ios_notifications {
    void request_permission();
    void send_notification(const char* title, const char* body);
}

#endif
