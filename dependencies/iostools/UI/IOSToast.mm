#import "IOSToast.h"

@implementation IOSToast

+ (void)showToast:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (!rootVC) return;
        
        UIView *toastView = [[UIView alloc] init];
        toastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        toastView.layer.cornerRadius = 20;
        toastView.clipsToBounds = YES;
        toastView.alpha = 0.0;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = message;
        label.numberOfLines = 0;
        
        [toastView addSubview:label];
        [rootVC.view addSubview:toastView];
        
        toastView.translatesAutoresizingMaskIntoConstraints = NO;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.leadingAnchor constraintEqualToAnchor:toastView.leadingAnchor constant:16],
            [label.trailingAnchor constraintEqualToAnchor:toastView.trailingAnchor constant:-16],
            [label.topAnchor constraintEqualToAnchor:toastView.topAnchor constant:10],
            [label.bottomAnchor constraintEqualToAnchor:toastView.bottomAnchor constant:-10],
            
            [toastView.centerXAnchor constraintEqualToAnchor:rootVC.view.centerXAnchor],
            [toastView.bottomAnchor constraintEqualToAnchor:rootVC.view.safeAreaLayoutGuideBottomAnchor constant:-60],
            [toastView.widthAnchor constraintLessThanOrEqualToAnchor:rootVC.view.widthAnchor constant:-40]
        ]];
        
        [UIView animateWithDuration:0.3 animations:^{
            toastView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:2.0 options:0 animations:^{
                toastView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [toastView removeFromSuperview];
            }];
        }];
    });
}

@end

extern "C" void iostools_ui_show_toast(const char *msg) {
    [IOSToast showToast:[NSString stringWithUTF8String:msg]];
}
