//
//  eidtFanJuModel.h
//  yuefan
//
//  Created by zhangz on 15/11/13.
//  Copyright © 2015年 dtdxunlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eidtFanJuModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *centent;
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,copy)NSString *tag;
@property(nonatomic,strong)NSData *gifData;
+(eidtFanJuModel*)addTextCellModel;
+(eidtFanJuModel*)addPicCellModel:(UIImage*)img;
@end
