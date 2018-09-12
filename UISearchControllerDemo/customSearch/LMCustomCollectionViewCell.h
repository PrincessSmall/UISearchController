//
//  LMCustomCollectionViewCell.h
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/10.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const KLMCustomCollectionViewCell = @"KLMCustomCollectionViewCell";

@interface LMCustomCollectionViewCell : UICollectionViewCell

/**标签*/
@property (nonatomic , strong)UILabel * label;

@end
