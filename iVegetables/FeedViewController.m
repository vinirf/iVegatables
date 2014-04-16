//
//  FeedViewController.m
//  iVegetables
//
//  Created by VINICIUS RESENDE FIALHO on 16/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "FeedViewController.h"
#import "DateBaseNoticia.h"
#import "Noticia.h"

@interface FeedViewController ()

@end

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation FeedViewController

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
    [self serializarDados];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)serializarDados{

    NSString* url = @"http://www.revistavegetarianos.com.br/category/noticias/";
    NSURL* query = [NSURL URLWithString:url];
    NSString* result = [NSString stringWithContentsOfURL:query encoding:NSUTF8StringEncoding error:nil];

    NSString *string=result;
    NSRange searchFromRange = [string rangeOfString:@"grid_8"];
    NSRange searchToRange = [string rangeOfString:@"grid_4"];
    NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
    
    NSString *stringFinal = substring;
    
    NSRange continua =[stringFinal rangeOfString:@"<div class=\"post\">"];

    while(continua.location != NSNotFound){
        
        Noticia *news = [[Noticia alloc]init];
        
        stringFinal = [stringFinal substringFromIndex:continua.location];
        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"src"].location+5];
        news.imagem = [stringFinal substringToIndex:[stringFinal rangeOfString:@"class"].location-2];
        
        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@" title=\""].location+18];
        news.titulo = [stringFinal substringToIndex:[stringFinal rangeOfString:@"<span"].location-2];

        stringFinal = [stringFinal substringFromIndex:[stringFinal rangeOfString:@"<b>"].location+3];
        news.data = [stringFinal substringToIndex:[stringFinal rangeOfString:@"</b>"].location];
        

        [[DateBaseNoticia sharedManager]AddNoticia:news];
        
        NSLog(@"im %@ ",news.imagem);
        NSLog(@"im %@ ",news.titulo);
        NSLog(@"im %@ ",news.data);
        NSLog(@"\n");
        
        continua = [stringFinal rangeOfString:@"<div class=\"post\">"];
        
        
    }
    
    continua = [stringFinal rangeOfString:@"<div class=\"post\">"];
     [[self newsTable]reloadData];
}


//Números de seções
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//Número de linhas por seção
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DateBaseNoticia sharedManager]listaNoticias]count];
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
    Noticia *recipe = [[[DateBaseNoticia sharedManager]listaNoticias] objectAtIndex:[indexPath row]];
    
    //NSString *ImageURL = recipe.imagem;
    //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageWithContentsOfFile:@"http://www.revistavegetarianos.com.br/wp-content/uploads/2013/12/vegetarianos82image15-2-220x140.jpg"];
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    recipeNameLabel.text = recipe.titulo;
    
    UILabel *recipeRuaLabel = (UILabel *)[cell viewWithTag:102];
    recipeRuaLabel.text = recipe.data;
   
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Noticias Vegano "];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 130.0;
//}


@end
