//
//  TimePS.h
//  ScienerDemo
//
//  Created by 谢元潮 on 15/6/3.
//  Copyright (c) 2015年 谢元潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TimePS : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic) int16_t group;
@property (nonatomic) int16_t index;
@property (nonatomic, retain) NSString * lockname;

@end
