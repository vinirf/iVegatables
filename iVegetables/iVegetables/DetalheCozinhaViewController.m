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
    self.webInstrucoes.delegate = self;
    [self pegaFotoReceita];
    [self pegaDadosDaReceita];
    [self loadUIWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Método do delegate de webview, impede que a webview abra novos links
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return !(navigationType==UIWebViewNavigationTypeLinkClicked);
}

- (void)loadUIWebView{
    
    self.linkShared = [AuxWebNoticia sharedManager].linkReceita;
    NSURL *url = [NSURL URLWithString:self.linkShared];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webInstrucoes loadRequest: urlRequest];
    [self.webInstrucoes loadHTMLString:[self pegarDivNoticia] baseURL:url];
}


//Seleciona apenas o texto da noticia no html
-(NSString*)pegarDivNoticia{
    
    NSString* url = [AuxWebNoticia sharedManager].linkReceita;
    NSURL* query = [NSURL URLWithString:url];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];
    
    NSString *string=result;
    NSRange searchFromRange = [string rangeOfString:@"row span9 image-description show-description"];
    NSRange searchToRange = [string rangeOfString:@"span9 credit"];
    NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
    
    NSString *stringFinal = substring;
   
    stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"span9 image-description show-description"].location];
    
    NSString *caminhoUrl;
    
    if([stringFinal rangeOfString:@"span9 image-comments show-description"].location !=  NSNotFound){
         caminhoUrl = [stringFinal substringToIndex:[stringFinal rangeOfString:@"span9 image-comments show-description"].location-12];
    }else{
        caminhoUrl = [stringFinal substringToIndex:[stringFinal rangeOfString:@"span9 image-comments"].location-25];
    }
    
    NSString *caminhoUrl2 = [NSString stringWithFormat:@"%@%@",@"<div class=\"",caminhoUrl];
    
     NSLog(@"link = %@",caminhoUrl2);
    
    NSString *cabecalho = @"<!DOCTYPE > <html xmlns=""http://www.w3.org/1999/xhtml\" xml:lang=\"pt-br\" lang=\"pt-br\"> <head> </head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">";
    
    NSString *s = [NSString stringWithFormat:@"%@%@%@%@%@",cabecalho,@"<body><font face='Myriad Pro' size='5'><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=5.0; user-scalable=YES'/>",caminhoUrl2,@"</font></body>",@"</html>"];
    
    return s;
    
    
}


-(void)pegaFotoReceita{
    
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
