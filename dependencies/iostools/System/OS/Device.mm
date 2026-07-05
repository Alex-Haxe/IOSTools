#include "Device.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

value iostools_device_get_model() {
    struct utsname systemInfo;
    uname(&systemInfo);
    return alloc_string(systemInfo.machine);
}
DEFINE_PRIM(iostools_device_get_model, 0);

value iostools_device_get_system_version() {
    return alloc_string([[[UIDevice currentDevice] systemVersion] UTF8String]);
}
DEFINE_PRIM(iostools_device_get_system_version, 0);

value iostools_device_get_system_name() {
    return alloc_string([[[UIDevice currentDevice] systemName] UTF8String]);
}
DEFINE_PRIM(iostools_device_get_system_name, 0);

value iostools_device_get_name() {
    return alloc_string([[[UIDevice currentDevice] name] UTF8String]);
}
DEFINE_PRIM(iostools_device_get_name, 0);
