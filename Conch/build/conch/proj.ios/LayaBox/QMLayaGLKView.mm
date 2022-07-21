//
//  QMLayaGLKView.m
//  ZhaomiRN
//
//  Created by gaoxiaowei on 2022/6/14.
//

#import "QMLayaGLKView.h"
#import <GLKit/GLKit.h>

#define kQM_ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kQM_ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface QMLayaGLKView()<GLKViewDelegate>

@property (nonatomic, strong) GLKView       *gLKView;
@property (nonatomic, strong) EAGLContext   *gLContext;
@property (nonatomic, strong) conchRuntime  *conchRuntime;
@property (nonatomic, strong) CADisplayLink *displayLink;


@end

@implementation QMLayaGLKView
+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if(self){
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    [[conchConfig GetInstance]setAppEnv:@{@"app_url":@"http://game.zhaomi.cn/gather_dcc_test/index.js"}];
#ifdef DEBUG
    [[conchConfig GetInstance]setTheadMode:1];
#endif
    [self addSubview:self.gLKView];
    self.gLKView.delegate=self;
}

-(EAGLContext*)gLContext{
    if(!_gLContext){
        _gLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
        if (_gLContext) {
            NSLog(@"iOS OpenGL ES 3.0 context created");
        } else {
            _gLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
            if (_gLContext) {
                NSLog(@"iOS OpenGL ES 2.0 context created");
            } else {
                NSLog(@"iOS OpenGL ES 2.0 context created failed");
            }
        }
        //设置上下文
        [EAGLContext setCurrentContext:_gLContext];
    }
    return _gLContext;
}

-(GLKView*)gLKView{
    if(!_gLKView){
        _gLKView =[[GLKView alloc]initWithFrame:CGRectMake(0, 0, kQM_ScreenWidth, kQM_ScreenHeight)];
        _gLKView.context = self.gLContext;
        _gLKView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        _gLKView.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    }
    return _gLKView;
}

-(conchRuntime *)conchRuntime{
    if(!_conchRuntime){
        _conchRuntime = [[conchRuntime alloc]initWithView:self.gLKView EAGLContext:self.gLContext downloadThreadNum:3];
    }
    return _conchRuntime;
}

-(CADisplayLink*)displayLink{
    if(!_displayLink){
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawFrame)];
        _displayLink.preferredFramesPerSecond=45;
        _displayLink.paused=YES;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}

-(void)startRender{
    self.displayLink.paused=NO;
}

-(void)stopRender{
    if ([EAGLContext currentContext] == self.gLContext ) {
        [EAGLContext setCurrentContext:nil];
    }
    self.displayLink.paused=YES;
    [self.displayLink invalidate];
    [self.conchRuntime destory];
    [self.conchRuntime reset];
    [conchRuntime freeIOSConchRuntime];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.conchRuntime renderFrame];
}

- (void)drawFrame{
    [self.gLKView setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.conchRuntime touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.conchRuntime touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.conchRuntime touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.conchRuntime touchesCancelled:touches withEvent:event];
}

- (void)dealloc {
    NSLog(@"QMLayaGLKView dealoc.");
}
@end
