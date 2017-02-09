//
//  BBQSetPlaceViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSetPlaceViewController.h"
#import "BBQPlaceModel.h"
#import "BBQPlaceParam.h"

@interface BBQSetPlaceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *provinceses;
@property (nonatomic, copy) NSMutableString *placeStr;
@property (nonatomic, strong) BBQPlaceParam *placeParam;

@end

@implementation BBQSetPlaceViewController
- (NSArray *)provinceses
{
    if (!_provinceses) {
        self.provinceses = [[NSArray alloc] init];
    }
    return _provinceses;
}
- (NSMutableString *)placeStr
{
    if (!_placeStr) {
        self.placeStr = [[NSMutableString alloc] init];
    }
    return _placeStr;
}

- (BBQPlaceParam *)placeParam
{
    if (!_placeParam) {
        self.placeParam = [[BBQPlaceParam alloc] init];
    }
    return _placeParam;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height -54);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView =tableView;
    
    [self setupData];
}

- (void)returnText:(ReturnPlaceParamBlock)block {
    self.returnTextBlock = block;
}

-(void)setupData{
    [self getPlaceRequest:@0];
    
}
-(void)getPlaceRequest:(NSNumber *)node{
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"parentID"]= node;
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetPlace
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSLog(@"%@",responseObject);
         [SVProgressHUD dismiss];
         self.provinceses = [BBQPlaceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"district"]];
         if (self.provinceses.count ==0) {
             if (self.returnTextBlock != nil) {
                 self.returnTextBlock(self.placeStr,self.placeParam);
             }
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             [self.tableView reloadData];
         }
         
     } errorHandler:nil
     failureHandler:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.provinceses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"provienceCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //取出模型
    BBQPlaceModel *model = [[BBQPlaceModel alloc] init];
    model= self.provinceses[indexPath.row];
    //显示数据
    cell.textLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出模型
    BBQPlaceModel *model = [[BBQPlaceModel alloc] init];
    model= self.provinceses[indexPath.row];
    self.placeStr= [NSMutableString stringWithString:[self.placeStr stringByAppendingString:model.name]] ;
    if ([model.level integerValue] ==1) {
        self.placeParam.resideprovince = model.name;
    }else if ([model.level integerValue] ==2){
        self.placeParam.residecity = model.name;
    }else if ([model.level integerValue] ==3){
        self.placeParam.residedist= model.name;
    }
    if ([model.level integerValue] >=3) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(self.placeStr,self.placeParam);
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self getPlaceRequest:[NSNumber numberWithString:model.nodeid]];
    
    
}
@end
