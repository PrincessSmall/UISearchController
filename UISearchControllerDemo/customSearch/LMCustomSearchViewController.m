//
//  LMCustomSearchViewController.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/10.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMCustomSearchViewController.h"
#import "LMCustomCollectionViewCell.h"
#import "LMcustomLayout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface LMCustomSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

/**collectionView*/
@property (nonatomic , strong)UICollectionView * collectionView;

///**布局*/
@property (nonatomic , strong)LMcustomLayout * layout;

/**最近搜索数据源*/
@property (nonatomic , strong)NSMutableArray * historyData;
/**热门搜索数据源*/
@property (nonatomic , strong)NSMutableArray * hotData;

/**搜索框*/
@property (nonatomic , strong)UISearchBar * searchBar;

@end

@implementation LMCustomSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.searchBar];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}


#pragma  mark --lazy

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.searchBar.frame)+10, SCREEN_WIDTH-30, SCREEN_HEIGHT) collectionViewLayout:self.layout];
        //注册cell，区头区尾视图
        [_collectionView registerClass:[LMCustomCollectionViewCell class] forCellWithReuseIdentifier:KLMCustomCollectionViewCell];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewHeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionViewFooterView"];
        //数据没有布满一整个页面的时候，此项设置其可以上下滚动
        _collectionView.alwaysBounceVertical = YES;
        //设置滚动退出键盘
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        //遵守代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];

    }
    return _collectionView;
}

-(LMcustomLayout *)layout{
    if (!_layout) {
        
        _layout = [[LMcustomLayout alloc]init];
        //行间距
        _layout.minimumLineSpacing = 10;
        //列间距
        _layout.minimumInteritemSpacing = 10;
        //区头、区尾size
        _layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 30);
        _layout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 30);
        //滚动方向
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    }
    return _layout;
}

//历史搜索记录数据
-(NSMutableArray *)historyData{
    if (!_historyData) {
        
        _historyData = [NSMutableArray array];
        NSArray * arr = [[NSArray alloc]initWithObjects:@"老年人稚智能手机",@"mac",@"vgg转笔",@"搞笑另类的衣服",@"男士薄外套",@"棉花糖",@"玛咖",@"百褶裙",@"白裙女",@"牛仔白", nil];
        _historyData = [NSMutableArray arrayWithArray:arr];
        
    }
    return _historyData;
}

//热门搜索数据
-(NSMutableArray *)hotData{
    if (!_hotData) {
        
        NSArray * arr = [[NSArray alloc]initWithObjects:@"初秋女装韩版上衣",@"小小米max3",@"阔腿裤女",@"女士外套25-30岁",@"不规则卫衣女",@"男士外套",@"阿玛尼口红",@"条纹衬衫",@"小皮包 女 斜挎", @"多出来了",nil];
        _hotData = [NSMutableArray arrayWithArray:arr];
        
    }
    return _hotData;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        //搜索框风格
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        //搜索框提示
        _searchBar.placeholder = @"搜索你喜欢的任何商品名称";
        //是否展示取消按钮
        _searchBar.showsCancelButton = NO;
        //searchBar的光标，取消按钮的颜色
        _searchBar.tintColor = [UIColor blackColor];
        //searchBar遵守代理
        _searchBar.delegate = self;
        
    }
    return _searchBar;
}


#pragma  mark --UICollectionView代理方法实现

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LMCustomCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:KLMCustomCollectionViewCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[LMCustomCollectionViewCell alloc]init];
    }
    if (indexPath.section == 0) {
        cell.label.text = self.historyData[indexPath.item];
       
    }else if (indexPath.section == 1){
         cell.label.text = self.hotData[indexPath.item];
       
    }
    return cell;
    
}

//设置区头，区尾视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionViewHeaderView" forIndexPath:indexPath];
        UILabel * headerLab = [[UILabel alloc]initWithFrame:headerView.bounds];
       
        if (indexPath.section == 0) {
            UIButton * deletBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 4, 20, 22)];
            [deletBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            headerLab.text = @"历史搜索";
            [deletBtn setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
            deletBtn.contentMode = UIViewContentModeScaleAspectFit;
            [headerView addSubview:deletBtn];
            
        }else if (indexPath.section ==1){
            headerLab.text = @"热门搜索";
            UIImageView * hotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(75, 4, 22, 22)];
            hotImageView.image = [UIImage imageNamed:@"fire_icon"];
            [headerView addSubview:hotImageView];
        }
        headerLab.textColor = [UIColor blackColor];
        headerLab.font = [UIFont systemFontOfSize:17];
        [headerView addSubview:headerLab];
       
        return headerView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionViewFooterView" forIndexPath:indexPath];
        UILabel * footerLab = [[UILabel alloc]initWithFrame:footerView.bounds];
        footerLab.text = @"";
        footerLab.textColor = [UIColor blackColor];
        footerLab.font = [UIFont systemFontOfSize:17];
        [footerView addSubview:footerLab];
        return footerView;
    }
    return nil;
    
}


#pragma  mark --点击历史搜索的删除按钮

-(void)deleteBtnClicked{
    
    [self.historyData removeAllObjects];
    [self.collectionView reloadData];
}


#pragma  mark --UIFlowLayout代理方法实现

//section的内边距设置
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 80, 10, 10);
    
}

//item的size设置
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString * str ;
    if (indexPath.section == 0) {
        str = self.historyData[indexPath.item];
    }else{
        str = self.hotData[indexPath.item];
    }
    CGRect tempRect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40,2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}context:nil];
    CGFloat itemWidth = tempRect.size.width;
    return CGSizeMake(itemWidth, 25);

}


#pragma  mark --UISearchBarDelegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
    //修改searchBar右侧的cancelButton的文字内容
    for (id searchButtons in [[searchBar subviews][0]subviews ]) {
        if ([searchButtons isKindOfClass:[UIButton class]]) {
            UIButton * cancelButton = (UIButton *)searchButtons;
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

//点击searchBar的取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.collectionView layoutIfNeeded];
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
