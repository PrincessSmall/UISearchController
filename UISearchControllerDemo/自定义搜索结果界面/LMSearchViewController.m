//
//  LMSearchViewController.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/6.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMSearchViewController.h"
#import "LMResultViewController.h"
#import "LMDetailViewController.h"

static NSString * const cellIdentifier = @"cellIdentifier";

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LMSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>

/**tableView*/
@property (nonatomic , strong)UITableView * tableView;
/**searchController*/
@property (nonatomic , strong)UISearchController * searchController;

/**搜索结果控制器*/
@property (nonatomic , strong)LMResultViewController * resultVC;
/**数据源数组*/
@property (nonatomic , strong)NSArray * dataArr;

@end

@implementation LMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    //1. 创建searchController
    UISearchController * search = [[UISearchController alloc]initWithSearchResultsController:self.resultVC];
    search.dimsBackgroundDuringPresentation = NO;
    [search.searchBar sizeToFit];
    search.searchBar.placeholder = @"搜索";
    
    //2. 设置代理
    search.delegate = self;
    search.searchResultsUpdater = self.resultVC;
    search.searchBar.delegate = self.resultVC;
    
    
    //3. 添加searchBar到headerView
    self.tableView.tableHeaderView = search.searchBar;
    search.hidesNavigationBarDuringPresentation = YES;
    
//    //设置searchBar样式
//    search.searchBar.delegate = self;
//    search.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.searchController = search;
    
    self.definesPresentationContext = YES;//UIViewController中的属性，决定了那个父控制器的View，将会以优先于UIModalPresentationCurrentContext这种呈现方式来展现自己的View。如果没有父控制器设置这一属性，那么展示的控制器将会是根视图控制器。重要，避免searchBar弹出界面，因为我们需要将这个属性设置YES，告诉系统我们需要将UISearchControoller展示到当前的tableViewController上。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}


#pragma  mark -lazy

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.contentInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(LMResultViewController *)resultVC{
    if (!_resultVC) {
        _resultVC = [[LMResultViewController alloc]init];
        _resultVC.data = [self.dataArr copy];
    }
    return _resultVC;
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSArray alloc]init];
        NSMutableArray * arr = [NSMutableArray array];
        for (int i = 0; i<50; i++) {
            NSString * str = [NSString stringWithFormat:@"数据源%d",i];
            [arr addObject:str];
        }
        _dataArr = arr;
    }
    return _dataArr;
}


#pragma  mark --UITableViewDelegate代理方法实现

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LMDetailViewController * detailVc = [[LMDetailViewController alloc]init];
    detailVc.title = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}


#pragma  mark --UISearchCOntrollerDelegate代理方法实现

-(void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"willPresentSearchController");
}

-(void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"didPresentSearchController");
}

-(void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"willDismissSearchController");
}

-(void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"didDismissSearchController");
}

-(void)presentSearchController:(UISearchController *)searchController{
    NSLog(@"presentSearchController");
}


#pragma  mark --UISearchBarDelegate方法实现

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchController.searchBar resignFirstResponder];
    
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
