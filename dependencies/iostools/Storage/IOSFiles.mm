#import <UIKit/UIKit.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#include <hx/CFFI.h>
#include "IOSFiles.h"

@interface FilesDelegateHandler : NSObject <UIDocumentPickerDelegate>
@property (nonatomic) AutoGCRoot* successCallback;
@property (nonatomic) AutoGCRoot* cancelCallback;
@end

@implementation FilesDelegateHandler

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

namespace ios_files {
    static FilesDelegateHandler* delegateInstance = nil;

    void init_callbacks(value on_success, value on_cancel) {
        if (!delegateInstance) {
            delegateInstance = [[FilesDelegateHandler alloc] init];
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

extern "C" void ios_files_init(value on_success, value on_cancel) {
    ios_files::init_callbacks(on_success, on_cancel);
}
val_prime2(ios_files_init);

extern "C" void ios_files_pick_file() {
    ios_files::pick_file();
}
val_prime0(ios_files_pick_file);

extern "C" void ios_files_pick_folder() {
    ios_files::pick_folder();
}
val_prime0(ios_files_pick_folder);

extern "C" void ios_files_save(value name, value data) {
    ios_files::save_file(val_string(name), val_string(data));
}
val_prime2(ios_files_save);
