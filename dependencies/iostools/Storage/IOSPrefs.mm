#import "IOSPrefs.h"

@implementation IOSPrefs

+ (void)saveString:(NSString *)key value:(NSString *)val {
    [[NSUserDefaults standardUserDefaults] setObject:val forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getString:(NSString *)key {
    NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return val ? val : @"";
}

+ (void)saveBool:(NSString *)key value:(BOOL)val {
    [[NSUserDefaults standardUserDefaults] setBool:val forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBool:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end

extern "C" void iostools_storage_save_string(const char *key, const char *val) {
    [IOSPrefs saveString:[NSString stringWithUTF8String:key] value:[NSString stringWithUTF8String:val]];
}

extern "C" const char *iostools_storage_get_string(const char *key) {
    NSString *str = [IOSPrefs getString:[NSString stringWithUTF8String:key]];
    return [str UTF8String];
}

extern "C" void iostools_storage_save_bool(const char *key, bool val) {
    [IOSPrefs saveBool:[NSString stringWithUTF8String:key] value:val];
}

extern "C" bool iostools_storage_get_bool(const char *key) {
    return [IOSPrefs getBool:[NSString stringWithUTF8String:key]];
}
