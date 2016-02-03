//
//  MyLog.h
//  
//
//  Created by wan on 13-2-22.
//
//

#import <Foundation/Foundation.h>

@interface MyLog : NSObject

+(void) log:(NSString *)string isdebug:(BOOL)isDebug;
+ (void) logFormate:(NSString *)formatStr, ... ;
@end
