//
//  DetalheNewsViewController.m
//  iVegetables
//
//  Created by Vinicius Resende Fialho on 17/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "DetalheNewsViewController.h"
#import "AuxWebNoticia.h"

@interface DetalheNewsViewController ()

@end

@implementation DetalheNewsViewController

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
    // Do any additional setup after loading the view.
    self.webviewNews.delegate = self;
    [self loadUIWebView];
    [self pegarDivNoticia];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//Impede que a webview abra novos links
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return !(navigationType==UIWebViewNavigationTypeLinkClicked);;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
   
    //[detailsWebView setFrame:CGRectMake(detailsWebView.frame.origin.x, detailsWebView.frame.origin.y, 300.0, detailsWebView.frame.size.height)];
    CGSize constraint = CGSizeMake(200, 500);
    [self.webviewNews sizeThatFits:constraint];
}

- (void)loadUIWebView
{
    //UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
    self.linkShared = [AuxWebNoticia sharedManager].link;
    NSURL *url = [NSURL URLWithString:self.linkShared];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    CGRect upperRect = CGRectMake(200, 200, 624, 500);
//    self.webviewNews.frame = upperRect;
    
    
    [self.webviewNews loadRequest: urlRequest];
    
    
    [self.webviewNews loadHTMLString:[self pegarDivNoticia] baseURL:url];
    
}


-(NSString *)pegarDivNoticia{
    
    NSString* url = [AuxWebNoticia sharedManager].link;
    NSURL* query = [NSURL URLWithString:url];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];
    
    NSString *string=result;
    NSRange searchFromRange = [string rangeOfString:@"container_12"];
    NSRange searchToRange = [string rangeOfString:@"footer"];
    NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
    
    NSString *stringFinal = substring;
    
    stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"<!-- POST -->"].location+13];
    NSString *caminhoUrl = [stringFinal substringToIndex:[stringFinal rangeOfString:@"<!-- LEIA MAIS NA EDICAO X -->"].location];
    
    NSString *cabecalho = @"<!DOCTYPE > <html xmlns=""http://www.w3.org/1999/xhtml\" xml:lang=\"pt-br\" lang=\"pt-br\"> <style>p{font-size:14px; font-family:verdana} span.date b{font-size:16px} span.date{font-size:16px} h2{font-size:18px; font-family:verdana}</style><head> </head> <meta charset=\"UTF-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">";
    
    NSString *s = [NSString stringWithFormat:@"%@%@%@%@%@",cabecalho,@"<body bgcolor=#EAEAEA><font face='Myriad Pro' size='10'><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=5.0; user-scalable=YES'/>",caminhoUrl,@"</font></body>",@"</html>"];
    
    NSLog(@" df= %@",s);
    
    return s;
    
    
}


@end
