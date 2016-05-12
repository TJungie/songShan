//
//  JJHomeViewController.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import "JJHomeViewController.h"
#import "JJstatusCell.h"
#import "JJStatus.h"
#import "JJDataBase.h"
#import "FMDB.h"

@interface JJHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statusArray;

@end

@implementation JJHomeViewController

- (NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _statusArray = arr;
    }

    return _statusArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置头部标题
    self.title = @"首页";
    
    self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.width*0.75;
    
    //查询
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(query)];
    
    [self query];
}

- (void)query {
    
    [self.statusArray removeAllObjects];

    // 1.查询数据
    FMResultSet *rs = [[JJDataBase ShareDataBase].db executeQuery:@"select * from shareStatus order by id desc"];
    
    // 2.遍历结果集
    while (rs.next) {
        
        NSData *statusData = [rs dataForColumn:@"status"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
       JJStatus *status = [JJStatus statusWithDic:dic];
       [self.statusArray addObject:status];
        
    }

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JJstatusCell *cell = [JJstatusCell cellWithTableView:tableView];
    JJStatus *status = self.statusArray[indexPath.row];
    cell.status = status;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)refresh {
    
    [self query];

}
@end
