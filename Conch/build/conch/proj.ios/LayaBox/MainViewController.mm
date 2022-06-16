//
//  MainViewController.m
//  LayaBox
//
//  Created by gaoxiaowei on 2022/6/15.
//  Copyright © 2022 LayaBox. All rights reserved.
//

#import "MainViewController.h"
#import "GatherGLKViewController.h"
#import "NavViewController.h"
#import "ViewController.h"

@interface MainViewController ()
@property(nonatomic,strong)UIButton*button;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

-(void)setupViews{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.button];
}

-(UIButton*)button{
    if(!_button){
        _button =[[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2, (self.view.bounds.size.height-100)/2, 100, 100)];
        [_button setTitle:@"Gaher房间" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)buttonClick{
    GatherGLKViewController*vc =[[GatherGLKViewController alloc]init];
    NavViewController *nav = [[NavViewController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}
@end
