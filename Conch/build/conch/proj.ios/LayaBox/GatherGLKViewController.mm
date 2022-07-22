//
//  GatherGLKViewController.m
//  TryMyArrowNative
//
//  Created by sunluchuan on 2022/4/21.
//

#import "GatherGLKViewController.h"
#import "conchRuntime.h"
#import "QMLayaGLKView.h"
#import "NSObject+QMSafeArea.h"

#define QM_HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GatherGLKViewController ()
@property (nonatomic, strong) UIButton         *closeButton;
@property (nonatomic, strong) QMLayaGLKView    *glkView;
@end

@implementation GatherGLKViewController

- (void)viewDidLoad {
	[super viewDidLoad];
//    self.glkView=[QMLayaGLKView sharedInstance];
    self.glkView =[[QMLayaGLKView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.glkView];
    [self setupButtons];
    [self startRender];
}

- (void)startRender {
	//保持屏幕常亮，可以通过脚本设置
	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self.glkView startRender];
}

- (void)setupButtons {
    CGFloat safeaAreaTop = [self qm_safeArea].top;
    _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(9.5, safeaAreaTop ? : 20, 44, 44)];
    [_closeButton setImage:[UIImage imageNamed:@"gather_close"] forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor clearColor]];
    [_closeButton setTintColor:QM_HEXCOLOR(0xFFFFFF)];
    [_closeButton addTarget:self action:@selector(handleCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
}

- (void)handleCloseButtonClick {
    if(self.closeBlock!=nil){
        self.closeBlock();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.glkView stopRender];
    [self.glkView removeFromSuperview];
}

- (void)dealloc {
    NSLog(@"GatherGLKViewController dealoc");
}

- (void)didReceiveMemoryWarning{
	[super didReceiveMemoryWarning];
	[self.glkView.conchRuntime didReceiveMemoryWarning];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    /*
     UIInterfaceOrientationMaskPortrait,             ===2
     UIInterfaceOrientationMaskPortraitUpsideDown,   ===4
     UIInterfaceOrientationMaskLandscapeLeft,        ===8
     UIInterfaceOrientationMaskLandscapeRight,       ===16
     */
    return [conchConfig GetInstance]->m_nOrientationType;
}
@end
