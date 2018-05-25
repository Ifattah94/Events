//
//  FavoritesViewController.m
//  Events
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Event.h"
#import "FavoriteCell.h"
#import "PersistenceHelper.h"
#import "EventDetailViewController.h"


@interface FavoritesViewController ()
@property (nonatomic) NSArray <Event *> *events;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:FavoriteCell.class forCellReuseIdentifier:@"FavoriteCell"];
    _events = PersistenceHelper.shared.retrieveSavedEvents;
    
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCell *cell = (FavoriteCell *)[tableView dequeueReusableCellWithIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    Event *event = self.events[indexPath.row];
    [cell configureViewWithEvent:event];
    return cell;
}

#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Event *selectedEvent = [self events][indexPath.row];
    EventDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    detailVC.event = selectedEvent;
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end
