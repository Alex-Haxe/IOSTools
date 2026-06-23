#import <Foundation/Foundation.h>

@interface IOSPrefs : NSObject
+ (void)saveString:(NSString *)key value:(NSString *)val;
+ (NSString *)getString:(NSString *)key;
+ (void)saveBool:(NSString *)key value:(BOOL)val;
+ (BOOL)getBool:(NSString *)key;
@end
