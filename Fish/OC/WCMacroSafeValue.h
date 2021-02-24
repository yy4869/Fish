//
//  WCMacroSafeValue.h
//  WCMacroKit
//
//  Created by wesley_chen on 2019/3/9.
//

#ifndef WCMacroSafeValue_h
#define WCMacroSafeValue_h

#pragma mark - Safe Get Value

/**
 Safe get integer

 @param number the NSNumber
 @return the NSInteger. Return NSNotFound if the number is not NSNumber
 */
#define numberInteger(number) \
({ \
NSInteger integer = NSNotFound; \
if ([(number) isKindOfClass:[NSNumber class]]) { \
    integer = [(number) integerValue]; \
} \
integer; \
})

/**
 Safe get instance which is kind of class type

 @param object the unsafe object
 @param classType the class type
 @return the safe object
 */
#define ValueOfClassType(object, classType) (classType *)([(object) isKindOfClass:[classType class]] ? (object) : nil)

#define ValueOfDict(object)     ValueOfClassType(object, NSDictionary)
#define ValueOfDictM(object)    ValueOfClassType(object, NSMutableDictionary)

#define ValueOfArray(object)    ValueOfClassType(object, NSArray)
#define ValueOfArrayM(object)   ValueOfClassType(object, NSMutableArray)

#define ValueOfString(object)   ValueOfClassType(object, NSString)
#define ValueOfNumber(object)   ValueOfClassType(object, NSNumber)

#pragma mark - JSON Value

#pragma mark > Safe Get JSON Value

/**
 Get value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @param valueType the value type expected
 @param defaultValue the default value
 @return the value
 @discussion This method gets value from NSString or NSNumber unstrictly. Otherwise, get the defaultValue
 */
#define valueOfJSONValue(JSONValue, valueType, defaultValue) (([(JSONValue) isKindOfClass:[NSString class]] || [(JSONValue) isKindOfClass:[NSNumber class]]) ? [(NSString *)(JSONValue) valueType##Value] : (defaultValue))

/**
 Get double value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return 0.0
 */
#define doubleValueOfJSONValue(JSONValue)   valueOfJSONValue(JSONValue, double, 0.0)
/**
 Get float value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return 0.0f
 */
#define floatValueOfJSONValue(JSONValue)    valueOfJSONValue(JSONValue, float, 0.0f)
/**
 Get int value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return 0
 */
#define intValueOfJSONValue(JSONValue)      valueOfJSONValue(JSONValue, int, 0)
/**
 Get NSInteger value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return 0
 */
#define integerValueOfJSONValue(JSONValue)  valueOfJSONValue(JSONValue, integer, 0)
/**
 Get long long value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return 0
 */
#define longLongValueOfJSONValue(JSONValue) valueOfJSONValue(JSONValue, longLong, 0LL)
/**
 Get BOOL value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return NO
 */
#define boolValueOfJSONValue(JSONValue)     valueOfJSONValue(JSONValue, bool, NO)
/**
 Get NSString value from JSON value (NSString/NSNumber)

 @param JSONValue the JSON value (NSString, NSNumber, NSArray, NSDictionary, or NSNull) or others
 @return the value. Unexpected JSONValue will return nil
 */
#define stringValueOfJSONValue(JSONValue)   ([(JSONValue) isKindOfClass:[NSString class]] ? (JSONValue) : ([(JSONValue) isKindOfClass:[NSNumber class]]) ? [(NSNumber *)(JSONValue) stringValue] : nil)

/**
 Get JSON object from JSON string

 @param ... the JSON string
 @return the JSON object. Return nil if the JSON string is invalid.
 */
#define JSONObjectFromJSONString(...) \
({ \
    id JSONObject__; \
    @try { \
        JSONObject__ = [NSJSONSerialization JSONObjectWithData:[@#__VA_ARGS__ dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil]; \
    } \
    @catch (NSException *exception) { \
    } \
    JSONObject__; \
});

/**
 Get mutable JSON object from JSON string

 @param ... the JSON string
 @return the JSON object. Return nil if the JSON string is invalid.
 @discussion Return the JSON object with both mutable containers and leaves
 */
#define JSONMutableObjectFromJSONString(...) \
({ \
    id JSONObject__; \
    @try { \
        JSONObject__ = [NSJSONSerialization JSONObjectWithData:[@#__VA_ARGS__ dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil]; \
    } \
    @catch (NSException *exception) { \
    } \
    JSONObject__; \
});

#pragma mark - Key Value Pair Suite

/**
 Make a pair of key value

 @param key the key object
 @param value the value object
 @return the a pair of key value
 @see https://stackoverflow.com/a/33525373
 */
#define KeyValuePair(key, value)    @[((key) ?: [NSNull null]), ((value) ?: [NSNull null])]
/**
 The type of key value pair
 */
typedef NSArray * KeyValuePairType;
/**
 Check object if a key value pair

 @param object the object
 @return YES if the object is a key value pair, or return NO if not
 */
#define KeyValuePairValidate(object)  ([(object) isKindOfClass:[NSArray class]] && [(object) count] == 2)
/**
 Get the key object of pair

 @param pair the pair object
 @return the key object
 */
#define KeyOfPair(pair)             (KeyValuePairValidate(pair) ? ([pair firstObject] == [NSNull null] ? nil : [pair firstObject]) : nil)
/**
 Get the value object of pair

 @param pair the pair object
 @return the value object
 */
#define ValueOfPair(pair)           (KeyValuePairValidate(pair) ? ([pair lastObject] == [NSNull null] ? nil : [pair lastObject]) : nil)

#pragma mark - Safe float comparison

/**
 Safe compare two float or double equality

 @param f1 the float or double
 @param f2 the float or double
 @return YES if the f1 and f2 are equal by float type. Otherwise, NO
 */
#define FLOAT_COMPARE_EQUAL(f1, f2) (fabs((float)(f1) - (float)(f2)) < FLT_EPSILON)

#pragma mark - NSDictionary

/**
 NSDictionary safe get value

 @param dictionary the NSDictionary object
 @param key the key
 @param valueClassType the value class to check. If nil or @"", not check the value class
 @return the value if (1) dictionary is NSDictionary, (2) key not nil, (3) dictionary[key] exists, (4) value matches valueClassType when valueClassType not nil.
 Otherwise, return nil
 @code

 dict = @{
    @"key": @"date"
 };
 value = NSDICTIONARY_SAFE_GET(dict, @"key", NSString);
 value = NSDICTIONARY_SAFE_GET(dict, @"key", nil);
 value = NSDICTIONARY_SAFE_GET(dict, @"key", @"");

 @endcode
 */
#ifndef NSDICTIONARY_SAFE_GET
#define NSDICTIONARY_SAFE_GET(dictionary, key, valueClassType) \
({ \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wobjc-literal-conversion\"") \
    NSClassFromString(@#valueClassType) ? \
    (([(dictionary) isKindOfClass:[NSDictionary class]] && (key) && dictionary[(key)] && [dictionary[(key)] isKindOfClass:NSClassFromString(@#valueClassType)]) ? dictionary[(key)] : nil) : \
    (([(dictionary) isKindOfClass:[NSDictionary class]] && (key) && dictionary[(key)]) ? dictionary[(key)] : nil); \
    _Pragma("clang diagnostic pop") \
})

#endif /* NSDICTIONARY_SAFE_GET */

/**
 *  NSMutableDictionary calls setObject:forKey: method more safely
 */
#ifndef NSDICTIONARY_M_SAFE_SET
#define NSDICTIONARY_M_SAFE_SET(mutableDictionary, key, value) \
    do {                                                       \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-literal-conversion\"") \
        if ([mutableDictionary isKindOfClass:[NSMutableDictionary class]] && key && value) { \
            [mutableDictionary setObject:value forKey:key];    \
        }                                                      \
_Pragma("clang diagnostic pop") \
    } while (0)

#endif /* NSDICTIONARY_M_SAFE_SET */

#ifndef NSDICTIONARY_M_SAFE_ADD_ENTRIES
#define NSDICTIONARY_M_SAFE_ADD_ENTRIES(mutableDictionary, dictionary) \
    do {                                                               \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-literal-conversion\"") \
        if ([mutableDictionary isKindOfClass:[NSMutableDictionary class]] && dictionary) { \
            [mutableDictionary addEntriesFromDictionary:dictionary];   \
        }                                                              \
_Pragma("clang diagnostic pop") \
    } while (0)

#endif /* NSDICTIONARY_M_SAFE_ADD_ENTRIES */

/**
 Safe to wrap the literal dictionary

 @param ... the literal dictionary
 @return the literal dictionary if no nil keys or values. Return nil if key or value is nil

 @code

 dict = NSDICTIONARY_SAFE_WRAP(@{
     keyMaybeNil: @"value",
     @"key": valueMaybeNil
 });

 @endcode
 */
#ifndef NSDICTIONARY_SAFE_WRAP
#define NSDICTIONARY_SAFE_WRAP(...) ({ \
    NSDictionary *internalDict_; \
    @try { \
        internalDict_ = __VA_ARGS__; \
    } \
    @catch (NSException *e) {} \
    internalDict_; \
    })

#endif /* NSDICTIONARY_SAFE_WRAP */

#pragma mark > NSDictionary pairs

/**
 Safe to define a mutable dictionary

 @param dict the dict to define
 @param ... the key-value pairs by using NSDICTIONARY_M_PAIRS_SET macro
 @code

 NSDICTIONARY_M_PAIRS_DEFINE(dictM3,
    NSDICTIONARY_M_PAIRS_SET(@"key1", @"string")
    NSDICTIONARY_M_PAIRS_SET(@"key2", nil)
    NSDICTIONARY_M_PAIRS_SET(nil, @1)
 );
 // dictM3 will get @{ @"key1": @"string" }

 @endcode
 */
#define NSDICTIONARY_M_PAIRS_DEFINE(dict, ...) \
NSMutableDictionary *dict = \
({ \
NSMutableDictionary *dictM_internal__ = [NSMutableDictionary dictionary]; \
__VA_ARGS__; \
dictM_internal__; \
});

/**
 Return a safe mutable dictionary

 @param ... the key-value pairs by using NSDICTIONARY_M_PAIRS_SET macro
 @return the mutable dictionary
 @code

 NSMutableDictionary *data = NSDICTIONARY_M_PAIRS_RETURN(
     NSDICTIONARY_M_PAIRS_SET(@"a", @"A");
     NSDICTIONARY_M_PAIRS_SET(@"b", @"B");
     NSDICTIONARY_M_PAIRS_SET(@"c", nil);
     NSDICTIONARY_M_PAIRS_SET(nil, @"D");
 );
 // data will get @{ @"a": @"A", @"b": @"B" }

 @endcode
 */
#define NSDICTIONARY_M_PAIRS_RETURN(...) \
({ \
NSMutableDictionary *dictM_internal__ = [NSMutableDictionary dictionary]; \
__VA_ARGS__ \
dictM_internal__; \
});

/**
 Safe to set key-value

 @param key the key
 @param value the value
 @discussion This macro used in company with NSDICTIONARY_M_PAIRS_DEFINE or NSDICTIONARY_M_PAIRS_RETURN
 */
#define NSDICTIONARY_M_PAIRS_SET(key, value) \
if (key != nil) { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wnonnull\"") \
    dictM_internal__[key] = value; \
_Pragma("clang diagnostic pop") \
} \

#pragma mark > NSDictionary checking

/**
 Is a dict and not empty

 @param dict the NSDictionary object to expected
 @return Return YES if is a dict and not empty. Return NO if not.

 @code
 if (DICT_IF_NOT_EMPTY(dict)) {
    // do something
 }
 @endcode
 */
#define DICT_IF_NOT_EMPTY(dict)    ([(dict) isKindOfClass:[NSDictionary class]] && [(NSDictionary *)(dict) count])

/**
 Is a dict and empty

 @param dict the NSDictionary object to expected
 @return Return YES if is a dict and empty. Return NO if not.

 @code
 if (DICT_IF_EMPTY(dict)) {
    // do something
 }
 @endcode
 */
#define DICT_IF_EMPTY(dict)    ([(dict) isKindOfClass:[NSDictionary class]] && [(NSDictionary *)(dict) count] == 0)

#pragma mark - NSArray

/*!
 *  Replace elements of NSMutableArray
 *
 *  @param mutableArray the mutable array
 *  @param index        the index
 *  @param value        the value
 */
#ifndef NSARRAY_M_SAFE_SET
#define NSARRAY_M_SAFE_SET(mutableArray, index, value)                    \
    do {                                                                  \
        if ([mutableArray isKindOfClass:[NSMutableArray class]] && 0 <= index && index < [(NSMutableArray *)mutableArray count]) { \
            ((NSMutableArray *)mutableArray)[index] = value;                                  \
        }                                                                 \
    } while (0)

#endif /* NSARRAY_M_SAFE_SET */

// Note: in macro, use _Pragma("clang diagnostic push") instead of #pragma GCC diagnostic push
#ifndef NSARRAY_M_SAFE_ADD
#define NSARRAY_M_SAFE_ADD(mutableArray, value) \
    do { \
            id __value__ = value; \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-literal-conversion\"") \
            if ([mutableArray isKindOfClass:[NSMutableArray class]] && __value__) { \
                [(NSMutableArray *)mutableArray addObject:__value__]; \
            } \
_Pragma("clang diagnostic pop") \
    } while (0)

#endif /* NSARRAY_M_SAFE_ADD */

#ifndef NSARRAY_M_SAFE_REMOVE
#define NSARRAY_M_SAFE_REMOVE(mutableArray, index) \
    do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-literal-conversion\"") \
            if ([mutableArray isKindOfClass:[NSMutableArray class]] && 0 <= index && index < [(NSMutableArray *)mutableArray count]) { \
                [(NSMutableArray *)mutableArray removeObjectAtIndex:index]; \
            } \
_Pragma("clang diagnostic pop") \
    } while (0)

#endif /* NSARRAY_M_SAFE_REMOVE */

/*!
 *  Get value at index of NSArray
 *
 *  @param array the array
 *  @param index the index
 *
 *  @return the value at index. If nil, when index out of bound
 */
#ifndef NSARRAY_SAFE_GET
#define NSARRAY_SAFE_GET(array, index)                      \
    ({                                                      \
        id __value = nil;                                   \
        if ([array isKindOfClass:[NSArray class]] && 0 <= index && index < [(NSArray *)array count]) { \
            __value = [(NSArray *)array objectAtIndex:index];          \
        }                                                   \
        __value;                                            \
    })

#endif /* NSARRAY_SAFE_GET */


#ifndef NSARRAY_SAFE_WRAP
#define NSARRAY_SAFE_WRAP(...) ({ \
    NSArray *internalArr_; \
    @try { \
        internalArr_ = __VA_ARGS__; \
    } \
    @catch (NSException *e) {} \
        internalArr_; \
    });

#endif /* NSARRAY_SAFE_WRAP */

#pragma mark > NSArray checking

/**
 Is an array and not empty

 @param arr the NSArray object to expected
 @return Return YES if is an array and not empty. Return NO if not.

 @code
 if (ARR_IF_NOT_EMPTY(arr)) {
    // do something
 }
 @endcode
 */
#define ARR_IF_NOT_EMPTY(arr)    ([(arr) isKindOfClass:[NSArray class]] && [(NSArray *)(arr) count])

#pragma mark - NSObject

/**
 Safe to convert an object to another propert type object without warning.

 @param fromObejct the object to convert
 @param toObject the declared variable
 @param toClassName the class type to match, e.g. NSMutableString
 @textblock

 SomeModel *model = [SomeModel new];
 NSOBJECT_TYPE_CONVERT(model.a, declared_var, NSString);

 @textblock
 */
#define NSOBJECT_TYPE_CONVERT(fromObject, toObject, toClassName) \
toClassName *toObject = ({ \
    toClassName *__internal_return_value; \
    if ([(fromObject) isKindOfClass:[toClassName class]]) { \
        __internal_return_value = (toClassName *)(fromObject); \
    } \
    __internal_return_value; \
});

#pragma mark - NSData

#pragma mark > Data checking

/**
 Check is a NSData and not empty

 @param data NSData to expected
 */
#define DATA_IF_NOT_EMPTY(data)    ([(data) isKindOfClass:[NSData class]] && [(NSData *)(data) length])

#pragma mark - NSURL

/**
 Safe get a URL from NSString

 @param url NSString to expected
 @return the NSURL instance. If the url is a not string or empty will get a nil
 @discussion This method will trim the url at head and at trail.
 */
#define NSURL_SAFE_NEW(url) (([(url) isKindOfClass:[NSString class]] && (url).length) ? [NSURL URLWithString:[(url) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] : nil)

/**
 Safe get a file path URL from NSString

 @param url NSString to expected
 @return If the url is a not string or empty will get a nil
 */
#define NSURL_PATH_SAFE_NEW(path) (([(path) isKindOfClass:[NSString class]] && (path).length) ? [NSURL fileURLWithPath:(path)] : nil)

#pragma mark - File Path

/**
 Create a temp file path located in NSTemporaryDirectory()

 @param ext the file extension, e.g. @"txt". If nil, for without file extension.
 @return the file path
 @discussion the file name format is `tmp_<unix timestamp in ms>_<random number>`.

 @code

 NSString *filePath = TEMP_FILE_PATH_NEW(@"txt");
 BOOL success = [JEPGData writeToFile:filePath atomically:YES];

 @endcode
 */
#define TEMP_FILE_PATH_NEW(ext)  ([[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp_%ld_%u", (long)([[NSDate date] timeIntervalSince1970] * 1000), arc4random()]] stringByAppendingPathExtension:[(id)(ext) isKindOfClass:[NSString class]] ? (ext) : @""])

#pragma mark - Safe Pointer

/**
 Safe set pointer's value

 @param ptr the pointer
 @param value the value which ptr points to
 */
#define PTR_SAFE_SET(ptr, value) \
do { \
    if (ptr) { \
        *ptr = value; \
    } \
} while (0)

#pragma mark - Safe Comparison

#define DOUBLE_SAFE_MAX(a, b) \
({ \
double __returnValue; \
double __v1 = (a); \
double __v2 = (b); \
if (__v1 >= __v2) { \
    __returnValue = __v1; \
} \
else { \
    __returnValue = __v2; \
} \
__returnValue; \
});

#endif /* WCMacroSafeValue_h */
