//
//  ViewController.m
//  YLInputView
//
//  Created by 卢奕霖 on 17/8/10.
//  Copyright © 2017年 卢奕霖. All rights reserved.
//

#import "ViewController.h"
#import "YLInputView.h"

@interface ViewController ()

@property (nonatomic,strong) YLInputView *inputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YLInputView *view1 = [[YLInputView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2, 60, 250, 31)];
    view1.isAdapt = YES;
    view1.maxNumberOfLines = 4;
    view1.placeholder = @"自适应的输入框eg:消息的输入..";
    view1.tintColor = [UIColor blackColor];
    view1.placeholderColor = [UIColor redColor];
    view1.layer.cornerRadius = 4;
    view1.backgroundColor = [UIColor purpleColor];
//    view1.textAndPlaceholderContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 设置文本框最大行数
    
    [self.view addSubview:view1];
    
    
    YLInputView *view2 = [[YLInputView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-250)/2, 200, 250, 100)];
    view2.backgroundColor = [UIColor grayColor];
    view2.placeholder = @"固定的输入框eg:发布文章..";
    view2.maxNumberOfLines = 4;
    view2.placeholderColor = [UIColor redColor];
    view2.cursorColor = [UIColor blackColor];
    view2.isAdapt = NO;
    [self.view addSubview:view2];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
