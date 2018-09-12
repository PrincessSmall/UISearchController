//
//  LMResultViewController.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/6.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMResultViewController.h"
#import "LMDetailViewController.h"

static NSString * const cellIdentifier = @"cellIdentifier";
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LMResultViewController ()<UITableViewDelegate,UITableViewDataSource>

/**tableView*/
@property (nonatomic , strong)UITableView * tableView;
/**搜索结果 数据源*/
@property (nonatomic , strong)NSMutableArray * resultArr;
@end

@implementation LMResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view.
}

#pragma  mark -lazy

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.contentInset = UIEdgeInsetsZero;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)resultArr{
    if (!_resultArr) {
        _resultArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _resultArr;
}


#pragma  mark -UITableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.resultArr[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LMDetailViewController * detailVC = [[LMDetailViewController alloc]init];
    detailVC.title = self.resultArr[indexPath.row];
    
    [self.presentingViewController.navigationController pushViewController:detailVC animated:YES];//使用这个搜索结果界面可以push
//    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma  mark -UISearchResultUpdating必须实现的代理方法，更新控制器的搜索结果

//实现代理方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString * inputStr = searchController.searchBar.text;
    if (self.resultArr.count > 0) {
        [self.resultArr removeAllObjects];
    }
    for (NSString * str in self.data) {
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            [self.resultArr addObject:str];
        }
    }
    [self.tableView reloadData];
    
}


#pragma  mark --UISearchBarDelegate代理实现

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
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
