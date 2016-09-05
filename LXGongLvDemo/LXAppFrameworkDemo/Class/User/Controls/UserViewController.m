//
//  UserViewController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "UserViewController.h"
#import "ListCell.h"
#import "ListModel.h"

#import "DetailViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *listTableView;
@property (nonatomic,strong)NSArray *listArray;


@end

static NSString *const listCell=@"listCell";

@implementation UserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=Title2;
    self.view.backgroundColor=SFQBackgroundColor;
    self.listTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
}

-(void)initData{
    
    _listArray=nil;
    
    NSArray *temparray=[LXTools getDocumentFileData];
    
    NSMutableArray *arrayM=[NSMutableArray arrayWithCapacity:temparray.count];
    for (NSDictionary *dict in temparray) {

        ListModel *tg=[ListModel yy_modelWithDictionary:dict];
        if (tg.isCollect) {
            
            [arrayM addObject:tg];
            
        }
        
    }
    
    self.listArray= [arrayM mutableCopy];
    
    [_listTableView reloadData];
}

#pragma mark ---INIT---

-(NSArray *)listArray{
    if (!_listArray) {
        _listArray= [[NSArray alloc] init];
        
    }
    return _listArray;
}

-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.backgroundColor=[UIColor whiteColor];
        _listTableView.tableFooterView=[[UIView alloc] init];
        _listTableView.showsVerticalScrollIndicator=NO;
        _listTableView.rowHeight=130;
        _listTableView.delegate=self;
        _listTableView.dataSource=self;
        _listTableView.backgroundColor=SFQBackgroundColor;
        [_listTableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:listCell];
        [self.view addSubview:_listTableView];
    }
    return _listTableView;
}

#pragma mark ----UITableViewDataSource , UITableViewDelegate----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell forIndexPath:indexPath];
    cell.contentView.backgroundColor=SFQBackgroundColor;
    cell.listModel=_listArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVc=[[DetailViewController alloc] init];
    detailVc.model=_listArray[indexPath.row];
    detailVc.listIndex=indexPath.row;
    detailVc.sourceType=CollectListType;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}




@end
