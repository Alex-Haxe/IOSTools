#import <UIKit/UIKit.h>
#include <hx/CFFI.h>
#include "IOSHaptics.h"

namespace ios_haptics {

    void trigger_impact(int type) {
        UIImpactFeedbackStyle style = UIImpactFeedbackStyleMedium;
        if (type == 0) style = UIImpactFeedbackStyleLight;
        else if (type == 2) style = UIImpactFeedbackStyleHeavy;

        dispatch_async(dispatch_get_main_queue(), ^{
            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
            [generator prepare];
            [generator impactOccurred];
        });
    }

    void trigger_notification(int type) {
        UINotificationFeedbackType style = UINotificationFeedbackTypeSuccess;
        if (type == 1) style = UINotificationFeedbackTypeError;

        dispatch_async(dispatch_get_main_queue(), ^{
            UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
            [generator prepare];
            [generator notificationOccurred:style];
        });
    }
}

extern "C" void ios_haptics_trigger_impact(value type) {
    ios_haptics::trigger_impact(val_int(type));
}
DEFINE_PRIME1(ios_haptics_trigger_impact);

extern "C" void ios_haptics_trigger_notification(value type) {
    ios_haptics::trigger_notification(val_int(type));
}
DEFINE_PRIME1(ios_haptics_trigger_notification);
