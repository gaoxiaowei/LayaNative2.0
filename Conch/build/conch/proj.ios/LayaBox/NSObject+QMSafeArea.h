//
//  NSObject+QMSafeArea.h
//  QMCommonModule
//
//  Created by wangjian1 on 2021/11/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (QMSafeArea)
/// window.safearea
- (UIEdgeInsets)qm_safeArea;
- (NSDictionary *)insetsDict;

@end

NS_ASSUME_NONNULL_END
