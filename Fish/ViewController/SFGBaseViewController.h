//
//  SFGBaseViewController.h
//  Tutor
//
//  Created by yuec on 2020/12/27.
//  Copyright © 2020 fenbi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFGBaseViewController : UIViewController

@property (nonatomic, copy) void (^updateJumboIfNeeded)(void);

- (void)scrollToTop;

@end

NS_ASSUME_NONNULL_END
