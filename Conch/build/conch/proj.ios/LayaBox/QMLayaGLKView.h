//
//  QMLayaGLKView.h
//  ZhaomiRN
//
//  Created by gaoxiaowei on 2022/6/14.
//

#import <UIKit/UIKit.h>
#import "conchRuntime.h"

NS_ASSUME_NONNULL_BEGIN

@interface QMLayaGLKView : UIView
@property (nonatomic, strong,readonly) EAGLContext  *gLContext;
@property (nonatomic, strong,readonly) conchRuntime *conchRuntime;
+ (instancetype)sharedInstance;
-(void)startRender;
-(void)stopRender;
@end

NS_ASSUME_NONNULL_END
