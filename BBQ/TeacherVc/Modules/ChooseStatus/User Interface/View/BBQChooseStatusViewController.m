//
//  BBQChooseStatusViewController.m
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "BBQChooseStatusViewController.h"
#import "BBQChooseStatusCell.h"

@interface BBQChooseStatusViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *dataSource;

@end

@implementation BBQChooseStatusViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

#pragma mark - Interface
- (void)reloadEntries {
    [self.tableView reloadData];
}

- (void)reloadEntryAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)showBabyList:(NSArray *)data {
    self.dataSource = data;
    [self reloadEntries];
}

#pragma mark - Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQChooseStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseStatusCell" forIndexPath:indexPath];
    return cell;
    
}
#pragma mark - Event
- (IBAction)didTapNextButton:(id)sender {
    [self.eventHandler nextStep];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
