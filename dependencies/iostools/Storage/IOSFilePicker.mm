#import <UIKit/UIKit.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#include <hx/CFFI.h>
#include "IOSFilePicker.h"

@interface PickerDelegateHandler : NSObject <UIDocumentPickerDelegate>
@property (nonatomic) AutoGCRoot* successCallback;
@property (nonatomic) AutoGCRoot* cancelCallback;
@end

@implementation PickerDelegateHandler

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    NSURL *url = urls.firstObject;
    if (url && self.successCallback) {
        val_ July_call1(self.successCallback->get(), alloc_string([url.path UTF8String]));
    }
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    if (self.cancelCallback) {
        val_ July_call0(self.cancelCallback->get());
    }
}
@end

namespace ios_file_picker {
    static PickerDelegateHandler* delegateInstance = nil;

    void init_callbacks(value on_success, value on_cancel) {
        if (!delegateInstance) {
            delegateInstance = [[PickerDelegateHandler alloc] init];
        }
        delegateInstance.successCallback = new AutoGCRoot(on_success);
        delegateInstance.cancelCallback = new AutoGCRoot(on_cancel);
    }

    void pick_file() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[UTTypeData, UTTypeItem] asCopy:YES];
            picker.delegate = delegateInstance;
            [root presentViewController:picker animated:YES completion:nil];
        });
    }

    void pick_folder() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[UTTypeFolder]];
            picker.delegate = delegateInstance;
            [root presentViewController:picker animated:YES completion:nil];
        });
    }

    void save_file(const char* file_name, const char* content) {
        NSString *nsName = [NSString stringWithUTF8String:file_name];
        NSString *nsContent = [NSString stringWithUTF8String:content];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:nsName];
            [nsContent writeToFile:tempPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            NSURL *fileURL = [NSURL fileURLWithPath:tempPath];
            
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initForExportingURLs:@[fileURL] asCopy:YES];
            picker.delegate = delegateInstance;
            [root presentViewController:picker animated:YES completion:nil];
        });
    }
}

extern "C" void ios_file_picker_init(value on_success, value on_cancel) {
    ios_file_picker::init_callbacks(on_success, on_cancel);
}
val_prime2(ios_file_picker_init);

extern "C" void ios_file_picker_pick_file() {
    ios_file_picker::pick_file();
}
val_prime0(ios_file_picker_pick_file);

extern "C" void ios_file_picker_pick_folder() {
    ios_file_picker::pick_folder();
}
val_prime0(ios_file_picker_pick_folder);

extern "C" void ios_file_picker_save(value name, value data) {
    ios_file_picker::save_file(val_string(name), val_string(data));
}
val_prime2(ios_file_picker_save);
