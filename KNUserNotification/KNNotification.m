//
//  KNNotification.m
//  KNUserNotification
//
//  Created by 刘凡 on 2017/9/13.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNNotification.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"


@interface KNNotification ()<UNUserNotificationCenterDelegate>


@end

@implementation KNNotification

#pragma mark - 添加本地推送
MImplementeSharedInstance(SharedNotification)

-(instancetype)init
{
    self = [super init];
    if (self) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    return self;
}

- (void)registerNotifiCation {
    
    //请求获取通知权限（角标，声音，弹框）
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //允许
            NSLog(@"用户点击了允许弹出通知框");
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"通知框的设置为%@", settings);
            }];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }else{
            //不允许
            NSLog(@"用户不允许弹出通知框");
        }
    }];
}

-(void)addNotificationWithTimeIntervalTrigger{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"时间推送";
    content.subtitle = @"副标题";
    content.body = @"推送正文";
    content.sound = [UNNotificationSound soundNamed:@"music.caf"];
    
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:4 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TimeInterval" content:content trigger:timeTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加时间戳定时推送     :%@",error? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
    
}


-(void)addNotificationWithCalendarTrigger{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"日历推送";
    content.subtitle = @"副标题";
    content.body = @"推送正文";
    content.sound = [UNNotificationSound soundNamed:@"music.caf"];

    NSDateComponents *dateComponets = [[NSDateComponents alloc]init];
    dateComponets.weekday = 5;
    dateComponets.hour = 8;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponets repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Calendar" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加周期性定时推送    : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
    
}

-(void)addNotificationWithLocationTrigger{
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"位置推送";
    content.subtitle = @"副标题";
    content.body = @"推送正文";
    content.sound = [UNNotificationSound soundNamed:@"music.caf"];
    
    /*经纬度设置*/
    CLLocationCoordinate2D cen = CLLocationCoordinate2DMake(31.22, 121.53);
    CLRegion *region = [[CLCircularRegion alloc] initWithCenter:cen radius:100 identifier:@"center"];
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Calendar" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加位置推送 : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}


-(void)setCategories{
    UNNotificationAction *Action = [UNNotificationAction actionWithIdentifier:@"action" title:@"解锁" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction *Action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"启动app" options:UNNotificationActionOptionForeground];
    
    UNNotificationCategory *category1 = [UNNotificationCategory categoryWithIdentifier:@"yangshi1" actions:@[Action, Action1] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    
    UNNotificationAction *Action2 = [UNNotificationAction actionWithIdentifier:@"action3" title:@"红色样式" options:UNNotificationActionOptionDestructive];
    UNNotificationAction *Action3 = [UNNotificationAction actionWithIdentifier:@"action4" title:@"红色解锁启动" options:UNNotificationActionOptionAuthenticationRequired];
    
    UNNotificationCategory *category2 = [UNNotificationCategory categoryWithIdentifier:@"yangshi2" actions:@[Action2, Action3] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    UNTextInputNotificationAction *Action4 = [UNTextInputNotificationAction actionWithIdentifier:@"action5" title:@"" options:UNNotificationActionOptionForeground textInputButtonTitle:@"回复" textInputPlaceholder:@"在这里输入回复文字"];
    UNNotificationCategory *category3 = [UNNotificationCategory categoryWithIdentifier:@"yangshi3" actions:@[Action4] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category1, category2, category3, nil]];
}

//设置推送内容
-(UNMutableNotificationContent *)contentWithSubtitle:(NSString *)subtitle{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"本地推送通知";
    content.subtitle = subtitle;
    content.body = @"推送文件.图片/gif/音频/视频";
    content.sound = [UNNotificationSound soundNamed:@"music.caf"];

    return content;
}


-(void)addDelayNotificationWithContent:(UNNotificationContent *)content{
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TimeInterval" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加推送    %@",error ?[NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}

#pragma mark - ios10新特性: app在前台也能弹出通知框
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}


-(void)addNotificationWithCatrgories1{
    //添加第一个样式
    UNMutableNotificationContent *content = [self contentWithSubtitle:@"样式1"];
    //设置样式
    content.categoryIdentifier = @"yangshi1";
    //开始推送
    [self addDelayNotificationWithContent:content];
}

-(void)addNotificationWithCatrgories2{
    //添加第一个样式
    UNMutableNotificationContent *content = [self contentWithSubtitle:@"样式2"];
    //设置样式
    content.categoryIdentifier = @"yangshi2";
    //开始推送
    [self addDelayNotificationWithContent:content];
}

-(void)addNotificationWithCatrgories3{
    //添加第一个样式
    UNMutableNotificationContent *content = [self contentWithSubtitle:@"样式3"];
    //设置样式
    content.categoryIdentifier = @"yangshi3";
    //开始推送
    [self addDelayNotificationWithContent:content];
}

#pragma mark - 添加附件。 音频。图片。GIF，视频
- (void)addNotificationWithAttachmentType:(AttachmeType)type{
//
    NSString *contectSting = @"";
    NSString *path = @"";
    switch (type) {
        case AttachmeImage:
            contectSting = @"附件 - 图片";
            path = [[NSBundle mainBundle] pathForResource:@"731740" ofType:@"png"];
            break;
            case AttachmeImageGif:
            contectSting = @"附件 - gif";
            path = [[NSBundle mainBundle]pathForResource:@"basketball" ofType:@"gif"];
            break;
            case AttachmeAudio:
            contectSting = @"附件 - 音频";
            path = [[NSBundle mainBundle]pathForResource:@"AndyM - Falling" ofType:@"mp3"];
            break;
            case AttachmeMovie:
            contectSting = @"附件 - 视频";
            path = [[NSBundle mainBundle]pathForResource:@"纪念碑谷" ofType:@"mp4"];
            break;
        default:
            break;
            }
            //设置通知的contect
            UNMutableNotificationContent *content = [self contentWithSubtitle:contectSting];

            //设置一个error
            NSError *error;
            //设置推送的附件
            UNNotificationAttachment  *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"atta1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            if (attachment) {
                content.attachments = @[attachment];
            }

            [self addDelayNotificationWithContent:content];
    
}

#pragma mark - 添加自定义的样式
-(void)addLocalWithMyCategoriesUI{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.body = @"清仓大甩卖.~ 10块钱。只要10块钱";
    content.title = @"亲爱的小哥";
    content.sound = [UNNotificationSound soundNamed:@"music.caf"];
    
    content.categoryIdentifier = @"myNotificationCategory";
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"125" ofType:@"jpg"];
    
    UNNotificationAttachment *atta1 = [UNNotificationAttachment attachmentWithIdentifier:@"attat1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    
    if (error) {
        NSLog(@"atta1 error : %@",error);
    }
    
    if (atta1) {
        content.attachments = @[atta1];
    }
    
    //发送推送.
    [self addDelayNotificationWithContent:content];
}



@end
