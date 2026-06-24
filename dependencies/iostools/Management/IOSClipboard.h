#ifndef IOS_CLIPBOARD_H
#define IOS_CLIPBOARD_H

#include <string>

namespace ios_clipboard {
    void set_text(const char* text);
    const char* get_text();
}

#endif
