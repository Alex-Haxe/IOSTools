#include <Foundation/Foundation.h>
#import "iostools.h"

namespace iostools {
    
    void downloadFile(const char* urlStr, const char* filenameStr) {
        NSString *urlString = [NSString stringWithUTF8String:urlStr];
        NSString *filename = [NSString stringWithUTF8String:filenameStr];
        
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) return;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
            completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                if (error == nil && location != nil) {
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
                    NSURL *documentsDirectory = [urls firstObject];
                    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:filename];
                    
                    [fileManager removeItemAtURL:destinationURL error:nil];
                    [fileManager moveItemAtURL:location toURL:destinationURL error:nil];
                }
            }];
            
        [downloadTask resume];
    }

    void uploadFile(const char* urlStr, const char* filenameStr) {
        NSString *urlString = [NSString stringWithUTF8String:urlStr];
        NSString *filename = [NSString stringWithUTF8String:filenameStr];
        
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) return;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        NSURL *documentsDirectory = [urls firstObject];
        NSURL *fileURL = [documentsDirectory URLByAppendingPathComponent:filename];
        
        if (![fileManager fileExistsAtPath:[fileURL path]]) return;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
            fromFile:fileURL
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            }];
            
        [uploadTask resume];
    }
}
