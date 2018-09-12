//
//  LMResultViewController.h
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/6.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMResultViewController : UIViewController<UISearchResultsUpdating,UISearchBarDelegate>//.h文件中遵守协议

/**数据源*/
@property (nonatomic , strong)NSMutableArray * data;

@end
