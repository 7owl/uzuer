//
//  MyLog.m
//
//
//  Created by wan on 13-2-22.
//
//

#import "MyLog.h"

@implementation MyLog

bool DEBUG_LOG = true;

+(void) log:(NSString *)string isdebug:(BOOL)isDebug
{

    if (DEBUG_LOG && isDebug) {
        
        NSLog(@"%@",string);
        
    }
    
}

+ (void) logFormate:(NSString *)formatStr, ... {
    
    
    if (!formatStr)
        
        return;
    
    va_list arglist;
    
    va_start(arglist, formatStr);
    
    NSString *outStr = [[NSString alloc] initWithFormat:formatStr arguments:arglist];
    
    va_end(arglist);
    
    if (DEBUG_LOG) {
        
        NSLog(@"%@", outStr);
    }
    
}

//- (void) logFormate:(NSString *)formatStr, ... {
//    
//    if (!formatStr)
//        return;
//    
//    va_list arglist;
//    
//    va_start(arglist, formatStr);
//    
//    id arg;
//    
//    while((arg = va_arg(arglist, id))) {
//        
//        if (arg)
//            
//            NSLog(@"%@", arg);
//        
//    }
//    
//    va_end(arglist);
//    
//}

@end
