#import <UIKit/UIKit.h>
#include <hx/CFFIPrime.h>
#include "IOSClipboard.h"

namespace ios_clipboard {

    void set_text(const char* text) {
        NSString *nsText = [NSString stringWithUTF8String:text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIPasteboard generalPasteboard].string = nsText;
        });
    }

    const char* get_text() {
        __block NSString *nsText = @"";
        if ([NSThread isMainThread]) {
            nsText = [UIPasteboard generalPasteboard].string;
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                nsText = [UIPasteboard generalPasteboard].string;
            });
        }
        if (nsText == nil) {
            nsText = @"";
        }
        return [nsText UTF8String];
    }
}

extern "C" value ios_clipboard_set_text(value text) {
    ios_clipboard::set_text(val_string(text));
    return alloc_null();
}
DEFINE_PRIME1(ios_clipboard_set_text);

extern "C" value ios_clipboard_get_text() {
    return alloc_string(ios_clipboard::get_text());
}
DEFINE_PRIME0(ios_clipboard_get_text);
