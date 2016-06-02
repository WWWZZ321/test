//
//  DisplayViewController.h
//  yuefan
//
//  Created by zhangz on 15/11/19.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface DisplayViewController : RootViewController
@property(nonatomic,copy)NSString *titleString;


-(void)configWithArr:(NSMutableArray*)arr;
@end
