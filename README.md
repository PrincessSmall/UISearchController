# UISearchController

## 问题梳理

#### 问题1：searchBar被隐藏或者不正常显示问题

 * 原因1：UISearchController继承自UIViewController，也就是说UISearchController自身也带有一个View。但我们在使用UISearchController的时候并未将UISearchController自带的View添加在self.view上，也就是未指定哪个controller显示UISearchController自带View上的控件。
 
 * 解决1：使用UIViewController的属性definesPresentationContext设置为YES；即添加此代码self.definesPresentationContext = self;
 
#### 问题2：关于搜索结果界面的点击事件，没有push；
* 解决2：情况一，以自身为搜索结果界面时，是被蒙层遮住了，不显示蒙层就可以了，设置searchController.dimsBackgroundDuringPresentation = NO;
情况二，自定义搜索结果界面，push使用
[self.presentingViewController.navigationController pushViewController:detailVC animated:YES];

#### 问题3: 关于搜索结果界面，觉得searchBar过于靠近上方；
* 解决3: self.edgesForExtendedLayout = UIRectEdgeNone;加上这句就可以了； 
