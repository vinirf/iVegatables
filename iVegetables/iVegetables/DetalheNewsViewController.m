#import "DetalheNewsViewController.h"
#import "AuxWebNoticia.h"

@interface DetalheNewsViewController ()
@end



@implementation DetalheNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.webviewNews.delegate = self;
    
    [self loadUIWebView];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Método do delegate de webview, impede que a webview abra novos links
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return !(navigationType==UIWebViewNavigationTypeLinkClicked);
}

- (void)loadUIWebView{
   
    self.linkShared = [AuxWebNoticia sharedManager].link;
    NSURL *url = [NSURL URLWithString:self.linkShared];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [self.webviewNews loadRequest: urlRequest];
    [self.webviewNews loadHTMLString:[self pegarDivNoticia] baseURL:url];
}


//Seleciona apenas o texto da noticia no html
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
    
    return s;
    
    
}


@end
