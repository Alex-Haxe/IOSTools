#ifndef IOS_FILES_H
#define IOS_FILES_H

#include <hx/CFFI.h>

namespace ios_files {
    void init_callbacks(value on_success, value on_cancel);
    void pick_file();
    void pick_folder();
    void save_file(const char* file_name, const char* content);
}

#endif
