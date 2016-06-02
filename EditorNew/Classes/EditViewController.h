//
//  ViewController.h
//  yuefan
//
//  Created by zhangz on 15/11/12.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "RootViewController.h"
#import "eidtFanJuModel.h"
#define dataBack  1000
@interface EditViewController : RootViewController
@property(nonatomic,copy)NSString *topic;
//@property(copy,nonatomic)void (^creatMeal)(NSMutableArray* arr ,int status ,NSString *title,BOOL isOn);//编辑完
@property(copy,nonatomic)void (^creatMeal)(NSDictionary *dic);
@property(nonatomic,assign)BOOL isOld;//老饭局
@property(nonatomic,copy)NSString *mealId;
@property(nonatomic,assign)BOOL isFoodEdit;//美食编辑
@property(nonatomic,assign)BOOL isFoodOld;//daizuo
@property(nonatomic,assign)BOOL isEditor;

@property(nonatomic,weak)UIButton *fenmian;//封面
@property(nonatomic,strong)eidtFanJuModel *coverModel;
@property(nonatomic,strong)UIView *headView;//自定义头式图
@property(nonatomic,strong)UIView *rightBtnView;//右上角按钮
@property(nonatomic,strong)UITextView *textView;//小编推荐
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,assign)BOOL isMarry;
@property(nonatomic,copy)NSString *marryTips;
@property(nonatomic,assign)BOOL keyBoardhideStutes;
-(void)configWith:(NSArray*)arr;
-(NSArray*)creatFanju:(NSInteger)sender;
-(void)addRightBtn;
@end
