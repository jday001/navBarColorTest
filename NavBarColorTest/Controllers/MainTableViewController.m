//
//  MainTableViewController.m
//  NavBarColorTest
//
//  Created by Jeff Day on 3/11/15.
//  Copyright (c) 2015 JDay Apps, LLC. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"

@interface MainTableViewController ()

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *imagesArray;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // TODO: if navBar uses a background image, set it here
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - Lazy Initializers
- (NSArray *) itemsArray {
    if (!_itemsArray) {
        _itemsArray = @[@"Black Image", @"Blue Image", @"Red Image"];
    }
    return _itemsArray;
}

- (NSArray *) imagesArray {
    if (!_imagesArray) {
        _imagesArray = @[[UIImage imageNamed:@"blackBackground.jpg"],
                         [UIImage imageNamed:@"blueBackground.jpg"],
                         [UIImage imageNamed:@"redBackground.jpg"]
                         ];
    }
    return _imagesArray;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.itemsArray[indexPath.row];
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        
        // find indexPath for selected cell
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:selectedCell];
        
        // set image for detail view
        DetailViewController *detailVC = (DetailViewController *)[segue destinationViewController];
        detailVC.backgroundImage = self.imagesArray[selectedIndexPath.row];
        detailVC.title = self.itemsArray[selectedIndexPath.row];
    }
}

@end
