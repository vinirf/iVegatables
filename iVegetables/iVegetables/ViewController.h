//
//  ViewController.h
//  iVegetables
//
//  Created by Vinicius Resende Fialho on 15/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate,UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapVegetables;

@property CLLocationCoordinate2D posUsuario;

@property (weak, nonatomic) IBOutlet UITableView *Placestable;

@end
