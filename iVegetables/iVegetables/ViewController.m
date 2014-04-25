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



#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.mapVegetables.showsUserLocation = YES;
    [self.mapVegetables setDelegate:self];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        // Add observer
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *annotationIdentifier = @"annotationIdentifier";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    
    
    if (pinView.annotation == mapView.userLocation) {
        return nil;
        
    }else{
        [pinView setImage:[UIImage imageNamed:@"pino.png"]];
    }
    
    
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    pinView.selected = YES;
    
    return pinView;
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
    
    NSLog(@"lat %f",latitude);
    NSLog(@" long %f",longitude);
    
    NSString *thePath = [NSString stringWithFormat:@"%@%f%@%f%@%@%@%d",@"https://api.foursquare.com/v2/venues/explore?client_id=RSIWOOHN24O5YAXMEC2NL2TMDGN24KPHWTYOUHEMN5N3BBTC&client_secret=HC4QI0XA5LFBS3KJIZXYYNVVL3OZNFSW3WZKADCNKTIMKBGR&v=20130815&ll=",latitude,@",",longitude,@"&query=",termoPesquisa,@"&limit=",qtdPesquisa];
    
//    NSString *thePath = @"https://api.foursquare.com/v2/venues/explore?client_id=RSIWOOHN24O5YAXMEC2NL2TMDGN24KPHWTYOUHEMN5N3BBTC&client_secret=HC4QI0XA5LFBS3KJIZXYYNVVL3OZNFSW3WZKADCNKTIMKBGR&v=20130815&ll=-23.657196,-46.751254&query=vegetariano&limit=30";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:thePath]];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&error];
    
    for(int i=0;i<10;i++){
        
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
        //NSString *icone  =[r valueForKeyPath:@"hours.status"];
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
        
        NSLog(@"valores = %@",coordVeg.qtEstadoPreco);
        
    }
    
}

-(void)serializaDadosFourSquareLugares{
    float latitude = self.mapVegetables.userLocation.coordinate.latitude;
    float longitude = self.mapVegetables.userLocation.coordinate.longitude;
    NSString *termoPesquisa = @"vegetariano";
    int qtdPesquisa = 10;
    
    NSString *caminhoJson = [NSString stringWithFormat:@"%@%f%@%f%@%@%@%d",@"https://api.foursquare.com/v2/venues/search?client_id=RSIWOOHN24O5YAXMEC2NL2TMDGN24KPHWTYOUHEMN5N3BBTC&client_secret=HC4QI0XA5LFBS3KJIZXYYNVVL3OZNFSW3WZKADCNKTIMKBGR&v=20130815&ll=",latitude,@",",longitude,@"&query=",termoPesquisa,@"&limit=",qtdPesquisa];
    
    
}



-(void)marcarPosicaoNoMapa{
    
    for(int i=0;i<[[DateBaseCoordenadaVegetariano sharedManager]listaCoordenadasVegetarianos].count;i++){
        NSLog(@"string %d",i);
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
//    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
//    if(!cell){
//        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"UITableViewCell"];
//    }
//    
//    CoordenadaVegetariano *p = [[[DateBaseCoordenadaVegetariano sharedManager]listaCoordenadasVegetarianos] objectAtIndex:[indexPath row]];
//    [[cell textLabel] setFont:[UIFont systemFontOfSize:20.0]];
//    NSString *conc = [NSString stringWithFormat:@"%@,%@", [p nomeLugar], [p rua]];
//    [[cell textLabel]setText:conc];
//    //cell.imageView.image = [UIImage imageNamed:@"routes.png"];
//    
//    return cell;
    
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
    
    NSLog(@"qtd estrelas %i", [recipe.qtEstadoPreco integerValue]);
     NSLog(@"qtd  %@", recipe.qtEstadoPreco);
    
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
    recipeTelefoneLabel.text = recipe.telefone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoordenadaVegetariano *recipe = [[[DateBaseCoordenadaVegetariano sharedManager] listaCoordenadasVegetarianos] objectAtIndex: [indexPath row]];
    [AuxCoordenadaVegetariano sharedManager].coordenada = recipe;
    NSLog(@"guardou info restaurante");
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Restaurantes próximos à você"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

@end











