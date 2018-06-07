//
//  CategoryTableViewController.m
//  QuizApp
//
//  Created by Sword Software on 17/01/18.
//  Copyright © 2018 Sword Software. All rights reserved.
//

#import "CategoryTableViewController.h"

@interface CategoryTableViewController ()
{
    NSArray *category;
}
@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    category = [[NSArray alloc] initWithObjects:@"General Knowledge",@"Entertainment: Books",@"Entertainment: Film",@"Entertainment: Music",@"Entertainment: Musical & Theatres",@"Entertainment: Television",@"Entertainment: Video Games",@"Entertainment: Board Games",@"Science & Nature",@"Computers",@"Mathematics",@"Mythology",@"Sports",@"Geography",@"History",@"Politics",@"Art",@"Celebrities",@"Animals",@"Vehicles",@"Comics",@"Gadgets",@"Japaneses Anime & Manga",@"Cartoon & Animations", nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [category count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OptionsController *opt = [self.storyboard instantiateViewControllerWithIdentifier:@"options"];
    opt.cate = indexPath.row + 9;
    [self.navigationController pushViewController:opt animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"category" forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"category"];
    }
    // Configure the cell...
    cell.textLabel.text = category[indexPath.row];
    return cell;
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

@end
