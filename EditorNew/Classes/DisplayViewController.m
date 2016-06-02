//
//  DisplayViewController.m
//  yuefan
//
//  Created by zhangz on 15/11/19.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import "DisplayViewController.h"
#import "eidtFanJuModel.h"

@interface DisplayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *dataArr;
@property (nonatomic ,weak)UITableView *table;
@property (nonatomic,weak)UIView *pageHead;
@property (nonatomic,weak)UIImageView *pageFoot;
@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setbackBtn:@"返回"];
    self.view.backgroundColor = ViewColor(254, 234, 13, 1);
//    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 64)];
//    v.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:v];
    [self addTitleViewWithTitle:@"预览"];
   self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(8, 0, kWIDTH-12, kHEIGHT-64) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.delegate =self;
    table.dataSource =self;
    self.table = table;
    table.bounces = NO;
    table.backgroundColor = ViewColor(254, 234, 13, 1);
//    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 50)];
//    UILabel *lb = [[UILabel alloc]initWithFrame:head.frame];
//    lb.textAlignment = NSTextAlignmentCenter;
//    lb.font = [UIFont systemFontOfSize:20];
//    lb.text = self.titleString;
//    [head addSubview:lb];
//    table.tableHeaderView = head;
    [self creatFootView2];
    [self.view addSubview:table];
    
}
-(void)creatFootView2{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _table.frame.size.width, 148)];
    UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, headView.frame.size.width, 42)];
    head.image = [UIImage imageNamed:@"Resouce.bundle/饭局详情－信纸拉边up@2x"];
    [headView addSubview:head];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(head.frame), _table.frame.size.width, 148-CGRectGetMaxY(head.frame))];
    v.backgroundColor = [UIColor whiteColor];
   // self.pageHead = v;
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(16, 34, 30, 18)];
       img1.image = [UIImage imageNamed:@"Resouce.bundle/左引号"];
    [v addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(_table.frame.size.width-17-30, 34, 30, 18)];
    img2.image = [UIImage imageNamed:@"Resouce.bundle/右引号"];
    [v addSubview:img2];

    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img1.frame), img1.frame.origin.y,img2.frame.origin.x - CGRectGetMaxX(img1.frame)  , 20)];
    la.textColor = ViewColor(43, 43, 43, 1);
    la.textAlignment = NSTextAlignmentCenter;
    la.text = @"分享一下";
    la.font = [UIFont systemFontOfSize:19];
    [v addSubview:la];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, _table.frame.size.width, 20)];
    titleLb.textColor = ViewColor(43, 43, 43, 1);
    titleLb.text = self.titleString;
    titleLb.textAlignment = NSTextAlignmentCenter;
    [v addSubview:titleLb];
    [headView addSubview:v];
    _table.tableHeaderView =headView;
   
    

    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _table.frame.size.width, 82)];
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _table.frame.size.width, 40)];
    v2.backgroundColor = [UIColor whiteColor];
    [footView addSubview:v2];
    UIImageView *foot = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 40, footView.frame.size.width, 10)];
   // foot.backgroundColor = [UIColor blackColor];
    foot.image = [UIImage imageNamed:@"Resouce.bundle/饭局详情－信纸底部"];
  //  self.pageFoot = foot;
    [footView addSubview:foot];
    _table.tableFooterView = footView;
    
    CGRect p = [foot convertRect:foot.frame toView:self.table];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(_table.frame.size.width-4, v.frame.origin.y, 4, CGRectGetMaxY(p)-46-43)];
    
    line.backgroundColor = ViewColor(254, 203, 10, 1);
    [_table addSubview:line];
    [_table bringSubviewToFront:line];
    
}


-(void)configWithArr:(NSMutableArray *)arr{
    self.dataArr = [NSArray arrayWithArray:arr];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    eidtFanJuModel *mode = _dataArr [indexPath.row];
    if ([mode.type isEqualToString:@"1"]) {

       CGSize size = CGSizeMake(kWIDTH-68, MAXFLOAT);
        UITextView *t = [[UITextView alloc]init];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 7;
        NSDictionary *att = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSParagraphStyleAttributeName:paragraph,
                              NSForegroundColorAttributeName: ViewColor(106, 106, 106, 1)
                              };
        t.attributedText = [[NSAttributedString alloc] initWithString:mode.centent attributes:att];

        CGSize txeViewsize = [t sizeThatFits:size];
        
//        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:mode.centent];
//        NSRange range = NSMakeRange(0, attrStr.length);
//        // 获取该段attributedString的属性字典
//        NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
//        CGSize txeViewsize = [mode.centent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        
        
//        CGSize labelsize = [mode.centent sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
        return txeViewsize.height+16;
    }else
    return mode.img.size.height*kWIDTH/mode.img.size.width+21;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectZero];
        img.tag = 1000;
        [cell addSubview:img];
        
        UITextView *lab = [[UITextView alloc]initWithFrame:CGRectZero];
        lab.font = [UIFont systemFontOfSize:14];
        lab.tag = 100;
        lab.userInteractionEnabled = NO;
        
//        lab.textAlignment = NSTextAlignmentJustified;
        [cell addSubview:lab];
    }
  //  cell.backgroundColor = [UIColor orangeColor];
    
    eidtFanJuModel *model = _dataArr[indexPath.row];
    UITextView *lb = [cell viewWithTag:100];
   // lb.backgroundColor = [UIColor blueColor];
    CGRect rect = CGRectZero;
    rect.size.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    UIImageView *imgv = (UIImageView*)[cell viewWithTag:1000];
    
    if ([model.type isEqualToString:@"1"]) {
        //wenzi
        lb.frame = CGRectMake(32, 0, kWIDTH-68, rect.size.height);
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 7;
        NSDictionary *att = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:14],
                              NSParagraphStyleAttributeName:paragraph,
                              NSForegroundColorAttributeName: ViewColor(106, 106, 106, 1)
                              };
        lb.attributedText = [[NSAttributedString alloc] initWithString:model.centent attributes:att];
       // lb.text = model.centent;
        //lb.textColor = ViewColor(106, 106, 106, 1);
        imgv.hidden=YES;
        lb.hidden = NO;
    }else{
        imgv.frame =CGRectMake(0, 0, kWIDTH-16, rect.size.height-16);
        imgv.layer.borderWidth = 3;
        imgv.layer.borderColor = [UIColor blackColor].CGColor;
        imgv.image = nil;
        imgv.image = model.img;
        imgv.hidden=NO;
        lb.hidden = YES;
    }
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
