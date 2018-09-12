//
//  LMCustomCollectionViewCell.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/10.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMCustomCollectionViewCell.h"

@interface LMCustomCollectionViewCell()



@end

@implementation LMCustomCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.label];
        
    }
    return self;
    
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = [UIColor grayColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}








@end
