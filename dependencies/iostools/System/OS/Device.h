#ifndef IOSTOOLS_DEVICE_H
#define IOSTOOLS_DEVICE_H

#define IMPLEMENT_API
#include <hx/CFFI.h>

value iostools_device_get_model();
value iostools_device_get_system_version();
value iostools_device_get_system_name();
value iostools_device_get_name();

#endif
