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

@end

NS_ASSUME_NONNULL_END



/**
 Return a safe dictionary literals
 @If key or value is nil, then catch the exception, return null.

 // eg:
 NSDictionary *dic2 = SafeDictLiteral(@{
     @"key": @"value",
     nilStr: @"value"
 });
 // dict will get null

 */
#define SafeDictLiteral(...) ({ \
    NSDictionary *internalDict_; \
    @try { \
        internalDict_ = __VA_ARGS__; \
    } \
    @catch (NSException *e) {} \
    internalDict_; \
})

/**
 Return a safe mutable dictionary
 @param ... the key-value pairs by using SafeDictPair macro
 @return the mutable dictionary

 NSDictionary *dict4 = SafeDict(
                                SafeDictPair(@"key1", @"value1");
                                SafeDictPair(nil, @"value");
                                SafeDictPair(@"key", nil);
                                SafeDictPair(nil, nil);
                                SafeDictPair(@"key2", @"value2");
                                );
 // data will get @{ @"key1": @"value1", @"key2": @"value2" }

 @endcode
 */
#define SafeDict(...) ({ \
    NSMutableDictionary *dictM_internal__ = [NSMutableDictionary dictionary]; \
    __VA_ARGS__ \
    dictM_internal__; \
})

/**
 Safe to set key-value
 @This macro should used in company with SafeDict!
 */
#define SafeDictPair(key, value) ({ \
    if (key != nil) { \
        dictM_internal__[key] = value; \
    } \
})

/**
 Return a safe array

 // eg1:
 NSArray *array = SafeArray(@"0", @"1", nilStr, @"3", nilStr);
 // array will get [@"0", @"1", @"3"]

 // eg2:
 NSArray *array2 = SafeArray(@[@"00"], SafeArray(nilStr), @[@"10", @"11"]);
 // array will get [[@"00"], [], [@"10", @"11"]]

 */
#define SafeArray(...) ( \
    [NSArraySafeLiteral arrayWithObjects: [NSArraySafeLiteral class], __VA_ARGS__, [NSArraySafeLiteral class]] \
)

@interface NSArraySafeLiteral : NSObject

+ (NSArray *)arrayWithObjects:(id)terminator, ...;

@end
