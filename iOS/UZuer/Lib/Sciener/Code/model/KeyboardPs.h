//
//  KeyboardPs.h
//  sciener
//
//  Created by 谢元潮 on 15/3/25.
//
//

#import <Foundation/Foundation.h>

@interface KeyboardPs : NSObject

//#define KEYBOARD_PS_TYPE_ADMIN              0  //管理员密码
#define KEYBOARD_PS_TYPE_NORMAL_ALL_DATE    1  //永久有效普通用户密码
#define KEYBOARD_PS_TYPE_LIMITED_TIMES      2  //次数密码
#define KEYBOARD_PS_TYPE_LIMITED_DATE       3  //期限密码

@property (nonatomic) int psId;
@property (nonatomic,retain) NSString* keyboardPs;
@property (nonatomic) int type;
@property (nonatomic,retain) NSDate* startDate;
@property (nonatomic,retain) NSDate* endDate;
@property (nonatomic,retain) NSDate* createDate;
@property (nonatomic) int times;
@property (nonatomic) int timesRemain;
@property (nonatomic,retain) NSString* uid;//使用者的id
@property (nonatomic,retain) NSString* userName;//使用者的name


@end
