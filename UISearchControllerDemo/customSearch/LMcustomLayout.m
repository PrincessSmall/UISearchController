//
//  LMcustomLayout.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/10.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMcustomLayout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LMcustomLayout()

///**内边距*/
//@property (nonatomic , assign)UIEdgeInsets  edgeInsets;
///**行间距*/
//@property (nonatomic , assign)CGFloat lineSpacing;
///**列间距*/
//@property (nonatomic , assign)CGFloat columnsSpacing;
///**行数*/
//@property (nonatomic , assign)NSInteger rows;
///**列数*/
//@property (nonatomic , assign)NSInteger columns;
///**存放每个cell的布局*/
//@property (nonatomic , strong)NSMutableArray * attributeArr;


@end

@implementation LMcustomLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    if (arr.count <= 0) {
        return nil;
    }
    //第一行只有一行的时候让其也居左显示
    UICollectionViewLayoutAttributes *firstLayoutAttributes = [arr firstObject];
    CGRect frame = firstLayoutAttributes.frame;
    frame.origin.x = self.sectionInset.left;
    firstLayoutAttributes.frame = frame;
    
    for (int i = 1; i < [arr count]; i++) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = arr[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = arr[i - 1];
        
        if (prevLayoutAttributes.frame.origin.y == currentLayoutAttributes.frame.origin.y) {
            NSInteger interitemSpacing = self.minimumInteritemSpacing;
            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            
            if(origin + interitemSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + interitemSpacing;
                currentLayoutAttributes.frame = frame;
            }
        }
        else {
            //一行只有一行的时候让其也居左显示
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = self.sectionInset.left;
            currentLayoutAttributes.frame = frame;
        }
    }
    return arr;
}








@end
