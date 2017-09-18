//
//  NotificationViewController.m
//  KNContect
//
//  Created by 刘凡 on 2017/9/14.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *bodyLable;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.title;
    self.bodyLable.text = notification.request.content.body;

    //获取图片路径
    UNNotificationAttachment *attachment = notification.request.content.attachments.firstObject;
    if (attachment) {
        self.imageView.image = [UIImage imageWithContentsOfFile:attachment.URL.path];
    }
}

@end
