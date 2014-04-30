//
//  KitchenViewController.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "KitchenViewController.h"
#import "Receita.h"
#import "DataBaseReceita.h"
#import "AuxWebNoticia.h"


@interface KitchenViewController ()

@end

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation KitchenViewController

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
    self.campBusca.delegate = self;
    self.valorDeslocamento = 130;
    self.auxStringBusca = 1;
    self.listRceitas.hidden = YES;
    self.lblSemRetorno.hidden = YES;
    blocosIngredientes = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    self.imgColher.userInteractionEnabled = YES;
    [self.imgColher addGestureRecognizer:singleTap];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetaReceitas{
    self.valorDeslocamento = 130;
    self.auxStringBusca = 1;
    self.listRceitas.hidden = YES;
    self.lblSemRetorno.hidden = YES;
    
    for(int i=0;i<blocosIngredientes.count;i++){
        UIImageView *coord = [blocosIngredientes  objectAtIndex:i];
        coord.hidden = YES;
    }
   
    
    [UIView animateWithDuration:2.0
                     animations:^(void){
                         CGRect moveColher = CGRectMake(520, 320, 100, 100);
                         self.imgColher.frame = moveColher;
                     } completion:^(BOOL finished){
                       
                     }];
}


- (IBAction)btnLimpar:(id)sender {
    [self resetaReceitas];
}


-(void)parseReceitasHtml{
    
    
    NSString *linkBusca = [NSString stringWithFormat:@"%@%@",@"http://www.menuvegano.com.br/article/search?q=",self.stringDeBusca];
    
    
    NSURL* query = [NSURL URLWithString:linkBusca];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];
    
    NSString *string=result;
    NSRange searchFromRange = [string rangeOfString:@"main-container"];
    NSRange searchToRange = [string rangeOfString:@"container footer"];
    NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
    

    
    NSString *stringFinal = substring;
    
    NSRange continua =[stringFinal rangeOfString:@"class=\"span3 galery\""];
    
    if([stringFinal rangeOfString:@"class=\"span3 galery\""].location == NSNotFound){
        self.lblSemRetorno.hidden = NO;
        self.listRceitas.hidden = YES;
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(resetaReceitas) userInfo:nil repeats:NO];

    }else{
        [myThread cancel];
        self.lblSemRetorno.hidden = YES;
        self.listRceitas.hidden = NO;
    }
    
    while(continua.location != NSNotFound){
        
        Receita *rect = [[Receita alloc]init];
        
        stringFinal = [stringFinal substringFromIndex:continua.location];
    
        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"fancyframe_ detailcursor"].location+33];
        NSString *caminhoUrl = [stringFinal substringToIndex:[stringFinal rangeOfString:@"title"].location-2];
        rect.subLink = caminhoUrl;
        
        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"<img src="].location+10];
        NSString *linkImagem = [stringFinal substringToIndex:[stringFinal rangeOfString:@"</a>"].location-4];
        rect.imagem = linkImagem;
        
        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"<h5>"].location+4];
        NSString *titulo = [stringFinal substringToIndex:[stringFinal rangeOfString:@"</h5>"].location];
        rect.nome = titulo;
        
        [[DataBaseReceita sharedManager]AddReceita:rect];
        
        continua = [stringFinal rangeOfString:@"class=\"span3 galery\""];
        
    }
    
    continua = [stringFinal rangeOfString:@"class=\"span3 galery\""];
    
    [self.listRceitas reloadData];
    
}


//Números de seções
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//Número de linhas por seção
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataBaseReceita sharedManager]listaReceitas]count];
}


//Preeche a tabela de rotas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    Receita *recipe = [[[DataBaseReceita sharedManager]listaReceitas] objectAtIndex:[indexPath row]];
    
    NSURL *url = [NSURL URLWithString:[recipe imagem]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data ];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:110];
    recipeImageView.image = img;
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    recipeNameLabel.text = recipe.nome;
   
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Receitas Vegano"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Receita *recipe = [[[DataBaseReceita sharedManager]listaReceitas] objectAtIndex:[indexPath row]];
    [AuxWebNoticia sharedManager].linkReceita = [recipe subLink];
    
}

-(void)giraColher{
    
    [UIView animateWithDuration:1.0
                     animations:^(void){
                         CGRect moveColher = CGRectMake(22, 250, 100, 100);
                         self.imgColher.frame = moveColher;
                     } completion:^(BOOL finished){
                         self.imgColher.frame =CGRectMake(42, 250, 100, 100);
                         [UIView animateWithDuration:1.0
                                          animations:^(void){
                                              CGRect moveColher = CGRectMake(22, 250, 100, 100);
                                              self.imgColher.frame = moveColher;
                                          } completion:^(BOOL finished){
                                              //self.imgColher.frame =CGRectMake(42, 250, 100, 100);
                                              [UIView animateWithDuration:1.0
                                                               animations:^(void){
                                                                   CGRect moveColher = CGRectMake(22, 250, 100, 100);
                                                                   self.imgColher.frame = moveColher;
                                                               } completion:^(BOOL finished){
                                                                   self.imgColher.frame =CGRectMake(42, 250, 100, 100);
                                                               }];
                                          }];
                     }];
}

-(void)moveColher{
    [UIView animateWithDuration:2.0
                     animations:^(void){
                         CGRect moveColher = CGRectMake(30, 250, 100, 100);
                         self.imgColher.frame = moveColher;
                     } completion:^(BOOL finished){
                         self.imgColher.frame =CGRectMake(22, 250, 100, 100);
                                                  
                     }];
    
    
}


-(void)tapDetected{
    NSData *data = [self.stringDeBusca dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    self.stringDeBusca = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    myThread =[[NSThread alloc]initWithTarget:self selector:@selector(moveColher) object:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(giraColher) userInfo:nil repeats:NO];

    [myThread start];
    
    [DataBaseReceita sharedManager].listaReceitas = [[NSMutableArray alloc]init];
    [self parseReceitasHtml];
    
    
}

- (IBAction)botaoPesquisar:(id)sender {
    [self descerIngrediente];
    [[self campBusca] resignFirstResponder];
}

-(void)descerIngrediente{
    NSLog(@" %@",[self campBusca].text);
    if(![[self campBusca].text  isEqual:@""]){

        fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 23, 70, 30)];
        fromLabel.text = [self campBusca].text;
        fromLabel.backgroundColor = [UIColor clearColor];
        fromLabel.textColor = [UIColor blackColor];
        fromLabel.textAlignment = NSTextAlignmentCenter;
        
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 70, 70)];
        imgView.image = [UIImage imageNamed:@"bloco.jpg"];
        imgView.layer.zPosition = -10;
        
        [imgView addSubview:fromLabel];
        [self.view addSubview:imgView];
        
        
        [UIView animateWithDuration:1.1 animations:^{
            CGRect moveAviaoDecolar = CGRectMake(30, 300, 70, 70);
            imgView.frame = moveAviaoDecolar;
        }
                         completion:^(BOOL finished){
                             if(finished){
                                 CGRect moveAviaoDecolar = CGRectMake(30, 10, 70, 70);
                                 imgView.frame = moveAviaoDecolar;
                                 
                                 imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.valorDeslocamento, 320, 60, 60)];
                                 imgView2.image = [UIImage imageNamed:@"bloco.jpg"];
                                 fromLabel.frame = CGRectMake(0, 15, 60, 30);
                                 [imgView2 addSubview:fromLabel];
                                 [self.view addSubview:imgView2];
                                 [blocosIngredientes addObject:imgView2];
                                 
                                 UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.valorDeslocamento-17, 340, 15, 15)];
                                 imgView3.image = [UIImage imageNamed:@"mais.png"];
                                 [blocosIngredientes addObject:imgView3];
                                 
                                 [self.view addSubview:imgView3];
                                 [self.view addSubview:imgView2];
                                 
                                 self.valorDeslocamento = self.valorDeslocamento + 80;
                                 
                                 
                                 NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"  ."];
                                 self.campBusca.text = [[self.campBusca.text componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString:@""];
                                 
                                 
                                 if(self.auxStringBusca == 1){
                                     self.stringDeBusca = self.campBusca.text;
                                 }else{
                                     self.stringDeBusca =  [NSString stringWithFormat:@"%@+%@",self.stringDeBusca,self.campBusca.text];
                                 }
                                 
                                 self.auxStringBusca +=1;
                                 self.campBusca.text = @"";
                                 
                             }
                         }];
    }
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
   
    [self descerIngrediente];
    [[self campBusca] resignFirstResponder];
    
    return YES;
}


@end


