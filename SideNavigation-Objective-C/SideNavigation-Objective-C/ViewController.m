//
//  ViewController.m
//  SideNavigation-Objective-C
//
//  Created by Steve on 2017/8/2.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "SideNavigation-Swift.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface ViewController ()

@property (nonatomic, strong) SideMenuManager *leftSide;
@property (nonatomic, strong) SideMenuManager *rightSide;
@property (nonatomic, strong) LeftViewController *left;
@property (nonatomic, strong) RightViewController *right;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _left = [LeftViewController new];
    _leftSide = [[SideMenuManager alloc] init:self left:_left];
    _right = [RightViewController new];
    _rightSide = [[SideMenuManager alloc] init:self right:_right];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
}

- (void)leftClick {
    [self presentViewController:_left animated:YES completion:nil];
}

- (void)rightClick {
    [self presentViewController:_right animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    NSLog(@"%@",  NSStringFromClass([self class]));
}

@end
