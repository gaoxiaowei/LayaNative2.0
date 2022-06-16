//
//  NSObject+QMSafeArea.m
//  QMCommonModule
//
//  Created by wangjian1 on 2021/11/2.
//

#import "NSObject+QMSafeArea.h"

@implementation NSObject (QMSafeArea)

- (UIEdgeInsets)qm_safeArea{
    __block UIEdgeInsets inset;
    if([NSThread isMainThread]){
        UIView *view = [[UIApplication sharedApplication].delegate window];
        if (@available(iOS 11.0, *)) {
            inset = view.safeAreaInsets;
            if (inset.bottom == 0) {
                inset = UIEdgeInsetsZero;
            }
        } else {
            inset = UIEdgeInsetsZero;
        }
        return inset;
    }
    // 不在主线程
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [[UIApplication sharedApplication].delegate window];
        if (@available(iOS 11.0, *)) {
            inset = view.safeAreaInsets;
            if (inset.bottom == 0) {
                inset = UIEdgeInsetsZero;
            }
        } else {
            inset = UIEdgeInsetsZero;
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return inset;
}

- (NSDictionary *)insetsDict {
	UIEdgeInsets insets = [self qm_safeArea];
	return @{
		@"left":@(insets.left),
		@"top":@(insets.top),
		@"bottom":@(insets.bottom),
		@"right":@(insets.right)
	};
}

@end
