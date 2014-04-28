//
//  DetalheCozinhaViewController.h
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 23/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalheCozinhaViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTempoPreparo;
@property (weak, nonatomic) IBOutlet UILabel *lblCozimento;
@property (weak, nonatomic) IBOutlet UILabel *lblRendimento;
@property (weak, nonatomic) IBOutlet UILabel *lblDificuldade;
@property (weak, nonatomic) IBOutlet UIWebView *webInstrucoes;

@property NSString *linkShared;

@end
