//
//  KNNotification.h
//  KNUserNotification
//
//  Created by 刘凡 on 2017/9/13.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"

//先定义一个推送附件的的类型
typedef NS_ENUM( NSInteger, AttachmeType){
    AttachmeImage,
    AttachmeImageGif,
    AttachmeAudio,
    AttachmeMovie
};


@interface KNNotification : NSObject

MInterfaceSharedInstance(SharedNotification)

//注册通知
- (void)registerNotifiCation;

#pragma mark - 添加本地推送
//添加推送。可以设置推送的时间间隔
-(void)addNotificationWithTimeIntervalTrigger;

//添加推送。载入日历？
- (void)addNotificationWithCalendarTrigger;

//添加推送位置
- (void)addNotificationWithLocationTrigger;

#pragma mark - Categories
//设置推送样式
-(void)setCategories;

-(void)addNotificationWithCatrgories1;

-(void)addNotificationWithCatrgories2;

-(void)addNotificationWithCatrgories3;

#pragma mark - 本地-附件

- (void)addNotificationWithAttachmentType:(AttachmeType)type;

#pragma mark - 自定义推送UI
-(void)addLocalWithMyCategoriesUI;

@end
