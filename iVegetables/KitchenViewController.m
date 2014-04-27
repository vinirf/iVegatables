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
    [self parseReceitasHtml];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)parseReceitasHtml{
    
    NSString *termoBusca = @"feijao";
    NSString *linkBusca = [NSString stringWithFormat:@"%@%@",@"http://www.menuvegano.com.br/article/search?q=",termoBusca];
    
    NSURL* query = [NSURL URLWithString:linkBusca];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];
    
    NSString *string=result;
    NSRange searchFromRange = [string rangeOfString:@"main-container"];
    NSRange searchToRange = [string rangeOfString:@"container footer"];
    NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];

    
    NSString *stringFinal = substring;
    
    NSRange continua =[stringFinal rangeOfString:@"class=\"span3 galery\""];
    
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



@end


