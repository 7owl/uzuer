//
//  CRC8.h
//  BTstackCocoa
//
//  Created by wan on 13-2-22.
//
//

#import <Foundation/Foundation.h>

@interface CRC8 : NSObject

+(int) computeWithDataToCRC:(int)dataToCRC seed:(int)seed;

+(int) computeWithDataToCRC:(int)dataToCRC;

+(int) computeWithDataToCrc:(Byte*)dataToCrc len:(int)len;

+(int) computeWithDataToCrc:(Byte*)dataToCrc off:(int)off len:(int)len;

+(int) computeWithDataToCrc:(Byte*)dataToCrc off:(int)off len:(int)len seed:(int)seed;

+(int) computeWithDataToCrc:(Byte*)dataToCrc len:(int)len seed:(int)seed;

+(Byte *) encodeWithDataToCrc:(Byte*)dataToCrc off:(int)off len:(int)len seed:(int)seed;

@end
