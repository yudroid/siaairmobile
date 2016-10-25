//
//  AddressBookViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/20.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AddressBookViewController.h"
#import "AddressBookTableViewCell.h"
#import "AddressBookGroupTableViewCell.h"
#import <objc/runtime.h>

const char * ALERTVIEW_BLOCK = "ALERTVIEW_BLOCK";
static const NSString *ADDRESSBOOK_TABLEGROUPCELL_IDENTIFIER = @"ADDRESSBOOK_TABLEGROUPCELL_IDENTIFIER";
static const NSString *ADDRESSBOOK_TABLECELL_IDENTIFIER = @"ADDRESSBOOK_TABLECELL_IDENTIFIER";

@interface AddressBookViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"通讯录"];
    [self titleViewAddBackBtn];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableArray = [NSMutableArray arrayWithArray:@[
                           @{
                               @"Name":@"朋友",
                               @"Group":@"YES",
                               @"Child":@[
                                       @{@"Name":@"张三",
                                         @"phone":@"10010",},
                                       @{@"Name":@"王五",
                                         @"phone":@"10010"}
                                       ]
                               },
                           @{
                               @"Name":@"家人",
                               @"Group":@"YES",
                               @"Child":@[@{@"Name":@"姐姐",
                                            @"phone":@"10010"},
                                          @{@"Name":@"妹妹",
                                            @"phone":@"10010"},
                                          @{@"Name":@"哥哥",
                                            @"phone":@"10010"},
                                          @{@"Name":@"弟弟",
                                            @"phone":@"10010"}]
                               },
                           @{
                               @"Name":@"陌生人",
                               @"Group":@"YES",
                               @"Child":@[
                                       @{@"Name":@"小王",
                                         @"phone":@"10010"},
                                       @{@"Name":@"小李",
                                         @"phone":@"10010"},
                                       @{@"Name":@"小红",
                                         @"phone":@"10010"}]
                               
                               }
                           ]];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( [ [_tableArray objectAtIndex: indexPath.row] objectForKey:@"Group"])
    {
        return 30;
    }
    return  60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dectionary = [_tableArray objectAtIndex:indexPath.row];
    if([dectionary objectForKey:@"Group"])
    {
        AddressBookGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLEGROUPCELL_IDENTIFIER];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"AddressBookGroupTableViewCell" owner:nil options:nil][0];
        }
        
        cell.namelLabel.text = [dectionary objectForKey:@"Name"];
        cell.tag = 1;
        return cell;
    }
    else
    {
        AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"AddressBookTableViewCell" owner:nil options:nil][0];
        }
        cell.nameLabel.text = [dectionary objectForKey:@"Name"];
        return cell;
    }
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithDictionary:[_tableArray objectAtIndex:indexPath.row]];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.textLabel.text);
    if([dictionary objectForKey:@"Group"])
    {
        NSArray *ChildArray = [dictionary objectForKey:@"Child"];
        NSMutableArray *PathArray = [NSMutableArray array];
        
        if(cell.tag==1)
        {
            [UIView animateWithDuration:0.3 animations:^{
                ((AddressBookGroupTableViewCell *)cell).headImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            }];
            cell.tag=2;
            for (int i =0 ;i<ChildArray.count;i++)
            {
                dictionary = [ChildArray objectAtIndex:i];
                [_tableArray insertObject:dictionary atIndex:i+indexPath.row+1];
                NSIndexPath *path = [NSIndexPath indexPathForRow:i+indexPath.row+1 inSection:0];
                [PathArray addObject:path];
            }
            [tableView insertRowsAtIndexPaths:PathArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                ((AddressBookGroupTableViewCell *)cell).headImageView.transform = CGAffineTransformMakeRotation(0);
            }];
            cell.tag=1;
            NSMutableIndexSet * deleteSet= [NSMutableIndexSet indexSet];
            for (NSDictionary *dic  in ChildArray)
            {
                NSInteger row= [_tableArray indexOfObject:dic];
                NSIndexPath * Path = [NSIndexPath indexPathForRow:row inSection:0];
                [PathArray addObject:Path];
                [deleteSet addIndex:row];
            }
            [_tableArray removeObjectsAtIndexes:deleteSet];
            [tableView deleteRowsAtIndexPaths:PathArray withRowAnimation:UITableViewRowAnimationBottom];
        }
    }else{
        NSString *phoneNumber = [NSString stringWithFormat:@"telprompt://%@",[dictionary objectForKey:@"phone"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }

}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"%ld",(long)buttonIndex);
//    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, ALERTVIEW_BLOCK);
//    block(buttonIndex);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
