//
//  DetalheCozinhaViewController.m
//  iVegetables
//
//  Created by EMERSON DE SOUZA BARROS on 23/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "DetalheCozinhaViewController.h"
#import "AuxWebNoticia.h"

@interface DetalheCozinhaViewController ()

@end

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation DetalheCozinhaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pegaFotoReceita];
    [self pegaDadosDaReceita];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pegaFotoReceita{
    
    ///NSString *linkBusca = @"http://www.menuvegano.com.br/article/show/894/feijao-tropeiro";
    NSString *linkBusca = [AuxWebNoticia sharedManager].linkReceita;
    NSLog(@"busca entra= %@",linkBusca);
    NSURL* query = [NSURL URLWithString:linkBusca];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];
    
    result = [result substringFromIndex:[result rangeOfString:@"auto image-single span6"].location+87];
    NSString *caminhoUrl = [result substringToIndex:[result rangeOfString:@"data-src="].location-3];
    
    NSURL *url = [NSURL URLWithString:caminhoUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data ];
    UIImageView *recipeImageView = (UIImageView *)[self.view viewWithTag:100];
    recipeImageView.image = img;
    
}

-(void)pegaDadosDaReceita{
    
    NSString *linkBusca = [AuxWebNoticia sharedManager].linkReceita;
    
    NSURL* query = [NSURL URLWithString:linkBusca];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];
    
    NSString *string=result;
    NSRange searchFromRange = [string rangeOfString:@"recipe-labels"];
    NSRange searchToRange = [string rangeOfString:@"height:50px;border-bottom:none"];
    NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
    
    NSString *stringFinal = substring;
    
    NSRange continua =[stringFinal rangeOfString:@"<li>"];
    
    int i=1;
    while(continua.location != NSNotFound){
        
        stringFinal = [stringFinal substringFromIndex:continua.location];
        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"</span>"].location+8];
        NSString *item = [stringFinal substringToIndex:[stringFinal rangeOfString:@"</li>"].location];
        
        NSLog(@"string %@",item);
        
        switch (i) {
            case 1:
                self.lblTempoPreparo.text = item;
                break;
            case 2:
                self.lblCozimento.text = item;
                break;
            case 3:
                self.lblDificuldade.text = item;
                break;
            case 4:
                self.lblRendimento.text = item;
                break;
                
            default:
                break;
        }
        
        continua = [stringFinal rangeOfString:@"<li>"];
        i=i+1;
        
    }
    
    
}


@end
