//
//  tools.h
//  BlueTooth-Test
//
//  Created by yao on 09/03/2016.
//  Copyright © 2016 yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface tools : NSObject
+ (NSData*)stringToByte:(NSString*)string;
+ (NSString*)hexadecimalString:(NSData *)data;
+ (void)ShowAlert:(NSString *)title :(NSString *)content;
@end
