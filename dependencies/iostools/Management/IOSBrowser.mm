#import <UIKit/UIKit.h>
#include <hx/CFFI.h>
#include "IOSBrowser.h"

namespace ios_browser {

    void open_url(const char* url) {
        NSString *nsUrl = [NSString stringWithUTF8String:url];
        NSURL *targetUrl = [NSURL URLWithString:nsUrl];
        
        if (targetUrl) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:targetUrl options:@{} completionHandler:nil];
            });
        }
    }
}

extern "C" void ios_browser_open_url(value url) {
    ios_browser::open_url(val_string(url));
}
DEFINE_PRIME1(ios_browser_open_url);
