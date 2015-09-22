//
//  AppDelegate.m
//  BS
//
//  Created by dzy on 15/9/4.
//  Copyright (c) 2015年 董震宇. All rights reserved.
//

#import "AppDelegate.h"
#import "DZYTabBarController.h"

@interface AppDelegate ()
//@property (nonatomic, strong) UIWindow *window2;
//@property (nonatomic, strong) UIWindow *window3;
@property (nonatomic, strong) UIWindow *topWindow;
@end

@implementation AppDelegate

#pragma mark - topWindow 相关
- (UIWindow *)topWindow
{
    if (!_topWindow) {
        _topWindow = [[UIWindow alloc] init];
        _topWindow.frame = CGRectMake(0, 0, DZYScreenW, 20);
        _topWindow.windowLevel = UIWindowLevelAlert;
        _topWindow.backgroundColor = [UIColor clearColor];
        _topWindow.hidden = NO;
        [_topWindow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    }
    return _topWindow;
}

- (void)topWindowClick
{
    // 取出所有的window
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    // 遍历程序中所有的控件
    for (UIWindow *window in windows) {
        [self searchSubviews:window];
//        DZYLog(@"%@", windows);
    }
}
/**
 * 搜索Subviews中所有的子控件 （递归 是需要传参数的）
 */
- (void)searchSubviews:(UIView *)superview
{
    for (UIScrollView *scrollView in superview.subviews) {
        [self searchSubviews:scrollView];
//        DZYLog(@"%@", scrollView);
        // 判断是否为scrollView
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        // 计算出scrollView在window坐标系上的矩形框
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:scrollView.window];
        CGRect windowRect = scrollView.window.bounds;
        
        // 判断scrollView的边框是否和window的边框交叉
        if (!CGRectIntersectsRect(scrollViewRect, windowRect)) continue;
        
        // 让scrollView滚动到最前面
        CGPoint offset = scrollView.contentOffset;
        // 偏移量不一定是0
        offset.y = - scrollView.contentInset.top;
        [scrollView setContentOffset:offset animated:YES];
    }
}
         
#pragma mark - 程序的生命周期
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.设置窗口根控制器
    DZYTabBarController *tabBarVc = [[DZYTabBarController alloc] init];
    
    self.window.rootViewController = tabBarVc;
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
//    UIWindow *window2 = [[UIWindow alloc] init];
//    window2.frame = CGRectMake(100, 100, 100, 100);
//    window2.windowLevel = UIWindowLevelAlert;
//    window2.backgroundColor = [UIColor redColor];
//    window2.hidden = NO;
//    self.window2 = window2;
    
//    UIWindow *window3 = [[UIWindow alloc] init];
//    window3.frame = CGRectMake(0, 0, 375, 20);
//    window3.windowLevel = UIWindowLevelAlert;
//    window3.backgroundColor = [UIColor yellowColor];
//    window3.hidden = NO;
//    self.window3 = window3;
//
//    // 如果想搞一个控件 让它在每个窗口都会显示 那么搞个窗口 优先级为alert
//    UIWindow *window2 = [[UIWindow alloc] init];
//    window2.frame = CGRectMake(300, 500, 50, 50);
//    window2.windowLevel = UIWindowLevelAlert;
//    window2.backgroundColor = [UIColor clearColor];
//    [window2 addSubview:[[UISwitch alloc] init]];
//    window2.hidden = NO;
//    self.window2 = window2;

    
    
    return YES;
}

//- (void)setupTopWindow
//{
//    self.topWindow = [[UIWindow alloc] init];
//    self.topWindow.frame = CGRectMake(0, 0, DZYScreenW, 20);
//    self.topWindow.windowLevel = UIWindowLevelAlert;
//    self.topWindow.backgroundColor = [UIColor yellowColor];
//    self.topWindow.hidden = NO;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
/**
 
 程序激活的时候调用一次 (当关闭程序 再次进入的时候 就又会调用一次)
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    DZYLogFunc;
    [self topWindow];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.520it.BS" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BS.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
