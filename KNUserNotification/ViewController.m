//
//  ViewController.m
//  KNUserNotification
//
//  Created by 刘凡 on 2017/9/13.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ViewController.h"
#import "KNNotification.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本地推送";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置数据
    self.dataArray = [NSArray arrayWithObjects:@"推送样式1",@"推送样式2",@"推送样式3",@"推送图片",@"推送gif",@"推送音频",@"推送视频",@"自定义样式", nil];
    //添加表格
    [self.view addSubview:self.tableView];
}


#pragma 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}



#pragma mark - 设置总共的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}

#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0://推送样式1
            [[KNNotification SharedNotification] addNotificationWithCatrgories1];
            break;
        case 1://推送样式2
             [[KNNotification SharedNotification] addNotificationWithCatrgories2];
            break;
        case 2://推送样式3
             [[KNNotification SharedNotification] addNotificationWithCatrgories3];
            break;
        case 3://推送图片
            [[KNNotification SharedNotification] addNotificationWithAttachmentType:AttachmeImage];
            break;
        case 4://推送gif
           [[KNNotification SharedNotification] addNotificationWithAttachmentType:AttachmeImageGif];
            break;
        case 5://推送音频
            [[KNNotification SharedNotification] addNotificationWithAttachmentType:AttachmeAudio];
            break;
        case 6://推送视频
            [[KNNotification SharedNotification] addNotificationWithAttachmentType:AttachmeMovie];
            break;
        case 7:
            [[KNNotification SharedNotification] addLocalWithMyCategoriesUI];
            break;
        default:

            break;
    }
}


#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
@end
