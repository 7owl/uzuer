//
//  LockFound.h
//  sciener
//
//  Created by 谢元潮 on 14/12/24.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface LockFound : NSObject

@property (nonatomic, retain) CBPeripheral * peripheral;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int rssi;
@property (nonatomic) BOOL isContainAdmin;
@property (nonatomic) int protocolCategory;
@property (nonatomic) int protocolVersion;
@property (nonatomic) int applyCatagory;
@property (nonatomic) int applyID;
@property (nonatomic) int applyID2;
@property (nonatomic, retain) NSString * macStr;

@property (nonatomic) int lockParkState;//车位锁的状态
@property (nonatomic) NSTimeInterval timeFounded;//搜索到lock的时间

-(id)initWithPeripheral:(CBPeripheral*)peripheral
                   name:(NSString*)name
                 macStr:(NSString*)macStr
                   rssi:(int)rssi
       protocolCategory:(int)protocolCategory
        protocolVersion:(int)protocolVersion
          applyCatagory:(int)applyCatagory
                applyID:(int)applyID
               applyID2:(int)applyID2
          lockParkState:(int)lockParkState
            timeFounded:(NSTimeInterval)timeFounded
         isContainAdmin:(BOOL)isContainAdmin;

@end
