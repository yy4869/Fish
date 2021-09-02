//
//  SFGBaseViewController.m
//  Tutor
//
//  Created by yuec on 2020/12/27.
//  Copyright © 2020 fenbi. All rights reserved.
//

#import "SFGBaseViewController.h"
#import "WCMacroSafeValue.h"

@import Masonry;

@interface SFGBaseViewController ()

@property (nonatomic, strong) UIView *praiseView;

@end

@implementation SFGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.5];
    self.title = @"test";
    
    [self setupUserInterface];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setupUserInterface {
    [self.view addSubview:self.praiseView];
    [self.praiseView mas_makeConstraints:^(MASConstraintMaker *maker) {
        maker.centerY.equalTo(self.view);
        maker.trailing.equalTo(self.view);
        maker.width.equalTo(@(66));
        maker.height.equalTo(@(34));
    }];
}

- (UIView *)praiseView {
    if (!_praiseView) {
        _praiseView = [[UIView alloc] init];
    }
    return _praiseView;
}

@end
