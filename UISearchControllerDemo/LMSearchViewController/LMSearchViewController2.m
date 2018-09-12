//
//  LMSearchViewController2.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/6.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMSearchViewController2.h"
#import "LMDetailViewController.h"

static NSString * const cellIdentifier = @"cellIdentifier";

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LMSearchViewController2 ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate>

/**tableView*/
@property (nonatomic , strong)UITableView * tableview;
/**searchController*/
@property (nonatomic , strong)UISearchController * searchController;
/**数据源数组*/
@property (nonatomic , strong)NSMutableArray * dataArr;
/**搜索结果数据*/
@property (nonatomic , strong)NSMutableArray * resultArr;

@end

@implementation LMSearchViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UISearchController,初始化方法，传nil即为使用当前界面作为搜索结果界面
    UISearchController * searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    
    //searchController.hidesNavigationBarDuringPresentation = NO;//是否隐藏navigationBar默认是YES，隐藏的
    searchController.dimsBackgroundDuringPresentation = NO;//默认是YES有一层蒙层，设置为NO就没有蒙层了
    //searchController.obscuresBackgroundDuringPresentation = NO;和dimsBackgroundDuringPresentation一样的效果，只是On tvOS, defaults to NO when contained in UISearchContainerViewController。
    
    //设置代理
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    
    //将searchBar作为tableHeaderView
    searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 60);
    self.tableview.tableHeaderView = searchController.searchBar;
    searchController.searchBar.placeholder = @"搜索";
    [searchController.searchBar sizeToFit];

    
    self.edgesForExtendedLayout = UIRectEdgeNone;//属性使得搜索框不会紧紧贴着屏幕顶层的电池边缘
    
    self.definesPresentationContext = self;//UIViewController中的属性，将UISearchViewController的view添加在了当前控制器View上。避免searchBar被遮挡，或者cell跳转时候依然在上面的情况
    
    self.searchController = searchController;
    
    // Do any additional setup after loading the view.
}


#pragma  mark --lazy

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i<50; i++) {
            NSString * str = [NSString stringWithFormat:@"数据源%d",i];
            [_dataArr addObject:str];
        }
    }
    return _dataArr;
}

-(NSMutableArray *)resultArr{
    if (!_resultArr) {
        _resultArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _resultArr;
}


#pragma  mark --UITabeleViewDelegate代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return self.resultArr.count;
    }else
        return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //active属性判断搜索框是否活跃状态，当前界面是搜索结果界面还是原展示界面
    if (self.searchController.active) {
        cell.textLabel.text =  self.resultArr[indexPath.row];
    }else{
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        
        LMDetailViewController * detailVC = [[LMDetailViewController alloc]init];
        detailVC.title = self.resultArr[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else{
        
        LMDetailViewController * detailVC = [[LMDetailViewController alloc]init];
        detailVC.title = self.dataArr[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
   
}


#pragma  mark --UISearchResultsUpdating
//UISearchResultsUpdating代理方法，跟新搜索结果界面
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString * inputStr = searchController.searchBar.text;
    if (self.resultArr.count > 0) {
        [self.resultArr removeAllObjects];
    }
    for (NSString * str in self.dataArr) {
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            [self.resultArr addObject:str];
        }
    }
    [self.tableview reloadData];
}


#pragma  mark --UISearchControllerDelegate
//UISearchControllerDelegate代理方法
-(void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"------willPresentSearchController");

}

-(void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"------didPresentSearchController");
}

-(void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"------willDismissSearchController");
}

-(void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"------didDismissSearchController");
}

-(void)presentSearchController:(UISearchController *)searchController{
    NSLog(@"-------presentSearchController");
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
