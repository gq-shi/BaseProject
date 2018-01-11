//
//  Macro+Common.h
//  BaseProject
//
//  Created by 史国强 on 2018/1/11.
//  Copyright © 2018年 ZS. All rights reserved.
//

#ifndef Macro_Common_h
#define Macro_Common_h

#import <HYBHelperKit/HYBCommonKit.h>
//登录改变
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

//获取非空字符串
#define kGetSafeString(s) kIsEmptyString((s)) ? @"" : (s)

#define kVersionLater(s) !([[UIDevice currentDevice] systemVersion].floatValue < (s))
//textField 站位文字颜色
#define kTextFieldPlaceholderColor(t,c)  [(t) setValue:(c) forKeyPath:@"_placeholderLabel.textColor"]
//textField 站位文字字体
#define kTextFieldPlaceholderFont(t,f) [(t) setValue:(f) forKeyPath:@"_placeholderLabel.font"]
// weakify
#define kWeakify(var) __weak __typeof(var) weak_##var = var;

// strongify
#define kStrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof(var) var = weak_##var; \
_Pragma("clang diagnostic pop")

#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define BPLOG(...) printf("%s: %s 第%d行: %s\n\n",[[[NSDate date] hyb_stringWithFormat:@"YYYY-MM-dd hh:mm:ss"] UTF8String], [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define BPLOG(...)
#endif

#endif /* Macro_Common_h */
