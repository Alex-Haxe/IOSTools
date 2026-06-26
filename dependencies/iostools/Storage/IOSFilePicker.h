#ifndef IOS_FILE_PICKER_H
#define IOS_FILE_PICKER_H

#include <hx/CFFI.h>

namespace ios_file_picker {
    void init_callbacks(value on_success, value on_cancel);
    void pick_file();
    void pick_folder();
    void save_file(const char* file_name, const char* content);
}

#endif
