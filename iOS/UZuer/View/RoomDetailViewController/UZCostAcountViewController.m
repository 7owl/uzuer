//
//  UZCostAcountViewController.m
//  UZuer
//
//  Created by xiaofeishen on 15/9/17.
//  Copyright © 2015年 CaydenK. All rights reserved.
//

#import "UZCostAcountViewController.h"
#import "CKAlert.h"
#import "UZRecommendRoom.h"
#import "UZAliPayManager.h"

@interface UZCostAcountViewController ()
@property(weak, nonatomic) IBOutlet UILabel *roomPriceLb;
@property(weak, nonatomic) IBOutlet UILabel *totalPriceLb; //借款总额
@property(weak, nonatomic) IBOutlet UILabel *rateLb; //利率
@property(weak, nonatomic) IBOutlet UILabel *monthInterestLb; //月利息
@property(weak, nonatomic) IBOutlet UILabel *monthPayLb; //月还款
@property(weak, nonatomic) IBOutlet UIButton *selButton;
@property(weak, nonatomic) IBOutlet UIButton *confirmButton;
@end

@implementation UZCostAcountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int roomPrice = (int)self.room.price;
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.roomPriceLb.text = [NSString stringWithFormat:@"%.0d元/月",roomPrice];
    self.totalPriceLb.text = [NSString stringWithFormat:@"%.0d",roomPrice * 12];
    self.monthInterestLb.text = [NSString stringWithFormat:@"%.2f",roomPrice * 0.08];
    self.monthPayLb.text = [NSString stringWithFormat:@"%.2f",roomPrice * 1.08];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selButtonClick:(id)sender
{
    self.selButton.selected =  !self.selButton.selected;
}

- (IBAction)confirmButton:(id)sender
{
    if (self.selButton.selected) {
        [UZAliPayManager createOrderAndPayWithRoom:self.room contractType:ContractTypeFenQi currentVC:self];
    } else {
        [CKAlert showAlertWithMsg:@"需要同意协议才能分期"];
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

@end
