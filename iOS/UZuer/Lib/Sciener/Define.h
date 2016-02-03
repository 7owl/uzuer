//
//  Define.h
//  ScienerDemo
//
//  Created by 谢元潮 on 14-10-29.
//  Copyright (c) 2014年 谢元潮. All rights reserved.
//

#ifndef ScienerDemo_Define_h
#define ScienerDemo_Define_h

//测试
//#define kScienerAppkey @"fd2ff35ee3d8424c8665c07b7b9a7f45"
//#define kScienerAppSecret @"d4a28e5dcccfeeba04d090beab42fbea"
//正式
//#define kScienerAppkey @"7946f0d923934a61baefb3303de4d132"
//#define kScienerAppSecret @"56d9721abbc3d22a58452c24131a5554"
//UU公寓
//#define kScienerAppkey @"61e1078874a045508bbcfc2df4409cad"
//#define kScienerAppSecret @"a378f9ade69cb98b775824f37b2ef845"

//#define kScienerAppkey @"1e1d476d45ac41e8a7f0e61bc1dfa91a"
//#define kScienerAppSecret @"3b22f4a2e878d72e12dae57a4d20a4d4"


#define kScienerRedirectUri @"http://www.sciener.cn"
//#define kScienerRedirectUri @"http://api.uuhome.me/sciener/getcode/android_v1/"


#define NET_REQUEST_ERROR_NO_DATA -1001

//时效密码
typedef enum {
    TIME_PS_GROUP_DAY_1D = 1,
    TIME_PS_GROUP_DAY_2D,
    TIME_PS_GROUP_DAY_3D,
    TIME_PS_GROUP_DAY_4D,
    TIME_PS_GROUP_DAY_5D,
    TIME_PS_GROUP_DAY_6D,
    TIME_PS_GROUP_DAY_7D,
    TIME_PS_GROUP_DAY_10M
} TimePsGroup;

#endif
