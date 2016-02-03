//
//  UZRoomConfigureView.m
//  UZuer
//
//  Created by xiaofeishen on 15/8/4.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZRoomConfigureView.h"
#import "UZRoomConfigureOptionView.h"
#import "UZRecommendRoom.h"

@interface UZRoomConfigureView ()

@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *bedV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *gasRangeV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *microwaveOvenV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *refrigeratorV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *wardrobeV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *airConditioningV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *showerV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *tvV;
@property(nonatomic, weak) IBOutlet UZRoomConfigureOptionView *washerV;

@property(nonatomic,assign) BOOL roomConfigureBed; //床
@property(nonatomic,assign) BOOL roomConfigureWardrobe; //衣柜
@property(nonatomic,assign) BOOL roomConfigureAirConditioning; //空调
@property(nonatomic,assign) BOOL roomConfigureTV; //电视机
@property(nonatomic,assign) BOOL roomConfigureGasRanges; //燃气灶
@property(nonatomic,assign) BOOL roomConfigureMicrowaveOven; //微波炉
@property(nonatomic,assign) BOOL roomConfigureRefrigerator; //冰箱
@property(nonatomic,assign) BOOL roomConfigureShower; //热水器
@property(nonatomic,assign) BOOL roomConfigureWasher; //洗衣机

@end
@implementation UZRoomConfigureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bedV.selImage = @"details_page_bed";
    self.bedV.unSelImage = @"details_page_bed_gray";
    self.bedV.title = @"床";
    
    self.gasRangeV.selImage = @"details_page_gas_ranges";
    self.gasRangeV.unSelImage = @"details_page_gas_ranges_gray";
    self.gasRangeV.title = @"燃气灶";
    
    self.microwaveOvenV.selImage = @"details_page_microwave_oven";
    self.microwaveOvenV.unSelImage = @"details_page_microwave_oven_gray";
    self.microwaveOvenV.title = @"微波炉";
    
    self.refrigeratorV.selImage = @"details_page_refrigerator";
    self.refrigeratorV.unSelImage = @"details_page_refrigerator_gray";
    self.refrigeratorV.title = @"冰箱";
    
    self.wardrobeV.selImage = @"details_page_wardrobe";
    self.wardrobeV.unSelImage = @"details_page_wardrobe_gray";
    self.wardrobeV.title = @"衣柜";
    
    self.airConditioningV.selImage = @"details_page_air_conditioning";
    self.airConditioningV.unSelImage = @"details_page_air_conditioning_gray";
    self.airConditioningV.title = @"空调";
    
    self.showerV.selImage = @"details_page_shower";
    self.showerV.unSelImage = @"details_page_shower_gray";
    self.showerV.title = @"热水器";
    
    self.tvV.selImage = @"details_page_tv";
    self.tvV.unSelImage = @"details_page_tv_gray";
    self.tvV.title = @"电视";
    
    self.washerV.selImage = @"details_page_washer";
    self.washerV.unSelImage = @"details_page_washer_gray";
    self.washerV.title = @"洗衣机";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bedV.selected = self.roomConfigureBed;
    self.gasRangeV.selected = self.roomConfigureGasRanges;
    self.microwaveOvenV.selected = self.roomConfigureMicrowaveOven;
    self.refrigeratorV.selected = self.roomConfigureRefrigerator;
    self.wardrobeV.selected = self.roomConfigureWardrobe;
    self.airConditioningV.selected = self.roomConfigureAirConditioning;
    self.showerV.selected = self.roomConfigureShower;
    self.tvV.selected = self.roomConfigureTV;
    self.washerV.selected = self.roomConfigureWasher;
}

#pragma mark setter & getter
- (void)setRoom:(UZRecommendRoom *)room
{
    if (_room != room) {
        _room = room;
        [self updateUI];
    }
}

- (void)updateUI
{
    self.roomConfigureAirConditioning = _room.air_conditioning;
    self.roomConfigureBed = _room.bed;
    self.roomConfigureGasRanges = _room.gasstove;
    self.roomConfigureMicrowaveOven = _room.microwaveOven;
    self.roomConfigureRefrigerator = _room.refrigerator;
    self.roomConfigureShower = _room.heater;
    self.roomConfigureTV = _room.tv;
    self.roomConfigureWardrobe = _room.wardrobe;
    self.roomConfigureWasher = _room.washing;
    [self layoutIfNeeded];
}

@end
