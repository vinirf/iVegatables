//
//  DetalheNewsViewController.h
//  iVegetables
//
//  Created by Vinicius Resende Fialho on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalheNewsViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webviewNews;
@property NSString *linkShared;

@end
