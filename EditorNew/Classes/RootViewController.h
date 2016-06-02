//
//  RootViewController.h
//  yuefan
//
//  Created by dtdxunlei on 15/11/5.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

-(void)addTitleViewWithTitle:(NSString *)title;

- (void)addTitleImageWithName:(NSString *)name;


-(void)setbackBtn:(NSString*)str;

-(void)Rootback;

-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
