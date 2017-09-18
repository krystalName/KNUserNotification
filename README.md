# KNUserNotification
### 自研究自定义推送样式的Demo

### 分为7种样式。自己触发推送  先上一张gif 
![](https://github.com/krystalName/KNUserNotification/blob/master/SystemNotification.gif)


## 这个是采用系统的原有样式。 定义样式的代码如下. 

``` objc

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
```
每一个UNNotificationCategory 就代表一个样式

###  还有一种就是获取到本地图片。或者gif. 音频, 视频. 都能直接在推送中观看..  以下是gif 

![](https://github.com/krystalName/KNUserNotification/blob/master/UserNotification.gif)

## 这个是使用本地的资源。 然后获取到其路径。 设置为样式。 再放到推送里面 代码如下

```objc

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
            path = [[NSBundle mainBundle]pathForResource:@"bao" ofType:@"gif"];
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

```

### 然后还有自定义的推送样式。 先上gif
![](https://github.com/krystalName/KNUserNotification/blob/master/MyNotification.gif)

### 使用storyboard定义的样式。
![](https://github.com/krystalName/KNUserNotification/blob/master/myNotifitionstyle.png)

获取到UNMutableNotificationContent 里面的推送内容~  觉得可以。 给我一个star哦～ 

