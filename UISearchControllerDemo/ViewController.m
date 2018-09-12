//
//  ViewController.m
//  UISearchControllerDemo
//
//  Created by 李敏 on 2018/9/6.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "ViewController.h"
#import "LMSearchViewController.h"
#import "LMSearchViewController2.h"
#import "LMCustomSearchViewController.h"

static NSString * const cellIdentifier = @"cellIdentifier";
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)UITableView * tablleView;


@property (nonatomic , strong)NSArray * arr;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tablleView = tableView;

    

    // Do any additional setup after loading the view, typically from a nib.
}

-(NSArray *)arr{
    if (!_arr) {
        _arr = [[NSArray alloc]initWithObjects:@"LMSearchViewController",@"自定义搜索结果控制器的展现",@"基于搜索数据自定义搜索界面", nil];
    }
    return _arr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.arr[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        LMSearchViewController2 * searchVC2 = [[LMSearchViewController2 alloc]init];
        [self.navigationController pushViewController:searchVC2 animated:YES];
        
      
    }else if (indexPath.row == 1){
        
        LMSearchViewController * searchVc = [[LMSearchViewController alloc]init];
        [self.navigationController pushViewController:searchVc animated:YES];
        
        
        
    }else if (indexPath.row == 2){
        
        LMCustomSearchViewController * searchVC = [[LMCustomSearchViewController alloc]init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
