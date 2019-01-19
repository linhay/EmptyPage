//
//  ViewController.m
//  EmptyPage@Objective-C
//
//  Created by linhey on 2019/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "ViewController.h"
#import <EmptyPage/EmptyPage.h>
#import <Masonry/Masonry.h>

@interface ViewController ()

@property(nonatomic, strong) UITableView* tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView = [[UITableView alloc] init];
  [self.view addSubview: self.tableView];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.left.equalTo(self.view);
    make.top.bottom.equalTo(self.view);
  }];
  
  
}


@end
