//
//  CamaraViewController.h
//  yuefan
//
//  Created by zhangz on 15/11/25.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "RootViewController.h"

@interface CamaraViewController : RootViewController
@property(nonatomic,copy)void (^getPic)(NSArray *img ,BOOL isfromCamera);
@end
