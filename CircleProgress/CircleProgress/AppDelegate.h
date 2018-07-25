//
//  AppDelegate.h
//  CircleProgress
//
//  Created by zhw_mac on 2018/7/25.
//  Copyright © 2018年 zhw_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

