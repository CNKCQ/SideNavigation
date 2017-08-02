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
    // Do any additional setup after loading the view, typically from a nib.
    _left = [LeftViewController new];
    _right = [RightViewController new];
    self.leftSide = [[SideMenuManager alloc] init:self left:_left];
    self.rightSide = [[SideMenuManager alloc] init:self right:_right];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
