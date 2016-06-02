 //
//  EditPublishCell.h
//  yuefan
//
//  Created by zhangz on 15/11/12.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "eidtFanJuModel.h"
//#import "PublishEditView.h"

@interface EditPublishCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cententView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;
@property (weak, nonatomic) IBOutlet UIButton *cutPicBtn;
//@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView_0;
@property (weak, nonatomic) IBOutlet UIView *bgView_nomal;
@property(copy,nonatomic)void (^add)(NSString *type);
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property(weak ,nonatomic)UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIView *buttomVIew;
@property(nonatomic,weak)eidtFanJuModel *model;
@property(copy,nonatomic)void (^refrshKeyBoard)();
-(void)ViewinitWithModel:(eidtFanJuModel*)model;
@property (weak, nonatomic) IBOutlet UILabel *marryLabel;
@property (weak, nonatomic) IBOutlet UIButton *marryTextBtn;
@property (weak, nonatomic) IBOutlet UIButton *marryImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *puTongTextBtn;
@property (weak, nonatomic) IBOutlet UIButton *puTongImgBtn;
@property (nonatomic, assign) BOOL isMarryVc;
@property (weak, nonatomic) IBOutlet UIButton *addMarryImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *addMarryTextBtn;
@property (weak, nonatomic) IBOutlet UIButton *addPuTongPicBtn;
@property (weak, nonatomic) IBOutlet UIButton *addPuTongTextBtn;
@end
