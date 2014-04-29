//
//  ViewController.m
//  iVegetables
//
//  Created by Vinicius Resende Fialho on 15/04/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "ViewController.h"
#import "CoordenadaVegetariano.h"
#import "DateBaseCoordenadaVegetariano.h"
#import "AuxCoordenadaVegetariano.h"
#import "AuxWebNoticia.h"



#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapVegetables setDelegate:self];
    
    
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        self.mapVegetables.showsUserLocation = YES;
        
        [self.mapVegetables.userLocation addObserver:self forKeyPath:@"location" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:NULL];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [[self navigationItem] setBackBarButtonItem:backButton];
        
        
    }else{
        self.mapVegetables.showsUserLocation = YES;
        
        [self.mapVegetables.userLocation addObserver:self forKeyPath:@"location" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:NULL];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        [[self navigationItem] setBackBarButtonItem:backButton];
    }
   
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self.mapVegetables.userLocation removeObserver:self forKeyPath:@"location" context:NULL];
    self.posUsuario = self.mapVegetables.userLocation.location.coordinate;
    
    [self pegarJson];
    [self marcarPosicaoNoMapa];
    [self zoomToUserRegion];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [[self mapVegetables] setCenterCoordinate: userLocation.location.coordinate];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *annotationViewReuseIdentifier = @"annotationViewReuseIdentifier";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[self.mapVegetables dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifier];
    }
    
    if (annotationView.annotation == self.mapVegetables.userLocation) {
        return nil;
        
    }else{
        annotationView.image = [UIImage imageNamed:@"pino.png"];
        annotationView.annotation = annotation;
    }
    
    annotationView.canShowCallout = YES;
    annotationView.selected = YES;
    
    return annotationView;
}


-(void)zoomToUserRegion {
    MKCoordinateRegion region;
    region.center.latitude = self.mapVegetables.userLocation.coordinate.latitude;
    region.center.longitude = self.mapVegetables.userLocation.coordinate.longitude;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    [self.mapVegetables setRegion:region];
}

-(void)pegarJson{
    
    float latitude = self.posUsuario.latitude;
    float longitude = self.posUsuario.longitude;
    NSString *termoPesquisa = @"vegetariano";
    int qtdPesquisa = 10;
    
    NSString *thePath = [NSString stringWithFormat:@"%@%f%@%f%@%@%@%d",@"https://api.foursquare.com/v2/venues/explore?client_id=RSIWOOHN24O5YAXMEC2NL2TMDGN24KPHWTYOUHEMN5N3BBTC&client_secret=HC4QI0XA5LFBS3KJIZXYYNVVL3OZNFSW3WZKADCNKTIMKBGR&v=20130815&ll=",latitude,@",",longitude,@"&query=",termoPesquisa,@"&limit=",qtdPesquisa];
     
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:thePath]];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&error];
    
    for(int i=0;i<qtdPesquisa;i++){
        
        NSDictionary *title = [[json valueForKeyPath:@"response.groups.items"] objectAtIndex:0];
        NSDictionary *r = [[title valueForKeyPath:@"venue"] objectAtIndex:i];
        
        NSString *nome = [r valueForKeyPath:@"name"];
        NSString *contato = [r valueForKeyPath:@"contact.formattedPhone"];
        NSString *rua = [r valueForKeyPath:@"location.address"];
        NSString *ruaCoom = [r valueForKeyPath:@"location.crossStreet"];
        NSString *latitude = [r valueForKeyPath:@"location.lat"];
        NSString *longitude = [r valueForKeyPath:@"location.lng"];
        NSString *distancia = [r valueForKeyPath:@"location.distance"];
        NSString *cep = [r valueForKeyPath:@"location.postalCode"];
        NSString *SiglaPais = [r valueForKeyPath:@"location.cc"];
        NSString *cidade = [r valueForKeyPath:@"location.city"];
        NSString *estado = [r valueForKeyPath:@"location.state"];
        NSString *pais = [r valueForKeyPath:@"location.country"];
        NSString *site  =[r valueForKeyPath:@"url"];
        NSString *numeroCheck  =[r valueForKeyPath:@"stats.checkinsCount"];
        NSString *totalFreq  =[r valueForKeyPath:@"stats.usersCount"];
        NSString *estadoPreco  =[r valueForKeyPath:@"price.message"];
        NSString *precoValor  =[r valueForKeyPath:@"price.tier"];
        NSString *raking  =[r valueForKeyPath:@"rating"];
    
        NSString *horarioFunc  =[r valueForKeyPath:@"hours.status"];
        NSString *idVenue = [r valueForKey:@"id"];
        
        NSDictionary *tl = [[title valueForKeyPath:@"tips"] objectAtIndex:i];
        NSString *nomeComentario = [[tl valueForKeyPath:@"user.firstName"]objectAtIndex:0];
        NSString *nome2Comentario = [[tl valueForKeyPath:@"user.lastName"]objectAtIndex:0];
        NSString *comentario = [[tl valueForKeyPath:@"text"]objectAtIndex:0];
        
        CoordenadaVegetariano *coordVeg = [[CoordenadaVegetariano alloc]init];
        coordVeg.nomeLugar = nome;
        coordVeg.telefone = contato;
        coordVeg.rua = rua;
        coordVeg.ruaComplemento = ruaCoom;
        coordVeg.pontoLatitude = [latitude floatValue];
        coordVeg.pontoLongitude = [longitude floatValue];
        coordVeg.distancia = distancia;
        coordVeg.cep = cep;
        coordVeg.siglaPais = SiglaPais;
        coordVeg.cidade = cidade;
        coordVeg.estado = estado;
        coordVeg.pais = pais;
        coordVeg.site = site;
        coordVeg.numeroChecking = numeroCheck;
        coordVeg.totalFrequentadores = totalFreq;
        coordVeg.estadoPreco = estadoPreco;
        coordVeg.qtEstadoPreco = precoValor;
        coordVeg.nota = raking;
        coordVeg.horarioFuncionamento = horarioFunc;
        NSString *nomeUsuarioCompleto = [NSString stringWithFormat:@"%@%@%@",nomeComentario,@" ",nome2Comentario];
        coordVeg.nomeUsuario = nomeUsuarioCompleto;
        coordVeg.comentario = comentario;
        coordVeg.idVenue = idVenue;
        
        CLLocationCoordinate2D localizacao;
        localizacao.latitude = coordVeg.pontoLatitude;
        localizacao.longitude = coordVeg.pontoLongitude;
        coordVeg.coordinate = localizacao;
        coordVeg.title = nome;
        
        NSString *thePath2 = [NSString stringWithFormat:@"%@%@%@",@"https://api.foursquare.com/v2/venues/",idVenue,@"/photos?oauth_token=GC5DHRXHPZNDP4STCZGUGZLP1QOXNRRZXMBSJSZVJKIRT15Y&v=20140425&limit=2"];
        NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:thePath2]];
        NSData *returnData2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
        NSError *error2;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData2 options:0 error:&error2];
        NSString *linkImagem;
                                   
        for(int i=0;i<1;i++){
            NSDictionary *title = [[json valueForKeyPath:@"response.photos.items"] objectAtIndex:i];
            NSString *sufixo = [title valueForKeyPath:@"suffix"];
            NSString *prefixo = @"https://irs0.4sqi.net/img/general/800x500";
            linkImagem = [NSString stringWithFormat:@"%@%@",prefixo,sufixo];
        }

        coordVeg.linkImagem = linkImagem;
        
        [[DateBaseCoordenadaVegetariano sharedManager]AddCoordenada:coordVeg];
        
        
    }
    
}

-(void)marcarPosicaoNoMapa{
    
    for(int i=0;i<[[DateBaseCoordenadaVegetariano sharedManager]listaCoordenadasVegetarianos].count;i++){
        [[self mapVegetables] addAnnotation: [[[DateBaseCoordenadaVegetariano sharedManager]listaCoordenadasVegetarianos]objectAtIndex:i]];
    }
    [[self Placestable]reloadData];

}



//Números de seções
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//Número de linhas por seção
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DateBaseCoordenadaVegetariano sharedManager]listaCoordenadasVegetarianos]count];
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
     CoordenadaVegetariano *recipe = [[[DateBaseCoordenadaVegetariano sharedManager]listaCoordenadasVegetarianos] objectAtIndex:[indexPath row]];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:@"pino.png"];
    
    //Notas
    UIImageView *alface1 = (UIImageView *)[cell viewWithTag: 1];
    UIImageView *alface2 = (UIImageView *)[cell viewWithTag: 2];
    UIImageView *alface3 = (UIImageView *)[cell viewWithTag: 3];
    UIImageView *alface4 = (UIImageView *)[cell viewWithTag: 4];
    
    switch ([recipe.qtEstadoPreco integerValue]) {
        case 1:
            alface1.alpha = 1;
            break;
        case 2:
            alface1.alpha = 1;
            alface2.alpha = 1;
            break;
        case 3:
            alface1.alpha = 1;
            alface2.alpha = 1;
            alface3.alpha = 1;
            break;
        case 4:
            alface1.alpha = 1;
            alface2.alpha = 1;
            alface3.alpha = 1;
            alface4.alpha = 1;
            break;
            
        default:
            break;
    }
    
    
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    recipeNameLabel.text = recipe.nomeLugar;
    
    UILabel *recipeRuaLabel = (UILabel *)[cell viewWithTag:102];
    recipeRuaLabel.text = recipe.rua;
    
    UILabel *recipeTelefoneLabel = (UILabel *)[cell viewWithTag:103];
    if(recipe.telefone == NULL) recipeTelefoneLabel.text = @"Sem Telefone";
    else recipeTelefoneLabel.text = recipe.telefone;
    
    UILabel *recipeNotaLabel = (UILabel *)[cell viewWithTag:106];
    if([recipe.nota doubleValue] == 0){
        recipeNotaLabel.text = @"-";
    }else{
        NSString *not = [NSString stringWithFormat:@"%.1f", [recipe.nota doubleValue]];
        recipeNotaLabel.text = not;
    }
    
    UILabel *recipeEstadoPrecoLabel = (UILabel *)[cell viewWithTag:104];
    NSString *estadoPreco = [NSString stringWithFormat:@"%@%@",@"Preco: ",recipe.estadoPreco];
    recipeEstadoPrecoLabel.text = estadoPreco;
    
    UILabel *recipeDistanciaLabel = (UILabel *)[cell viewWithTag:105];
    NSString *distancia = [NSString stringWithFormat:@"Distância até esse local é de %0.2f Km", [recipe.distancia floatValue]/1000];
    recipeDistanciaLabel.text = distancia;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoordenadaVegetariano *recipe = [[[DateBaseCoordenadaVegetariano sharedManager] listaCoordenadasVegetarianos] objectAtIndex: [indexPath row]];
    [AuxCoordenadaVegetariano sharedManager].coordenada = recipe;

}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Restaurantes próximos à você"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

@end











