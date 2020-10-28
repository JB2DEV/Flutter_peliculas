

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{

  String _apikey    = '1e92a5d1867dd29c0a45a5271f2b15f2'; //Key de la api
  String _url       = 'api.themoviedb.org'; //URl de la api simple
  String _language  = 'es-ES'; //Lenguaje

  int _popularesPage = 0; //Variable para ir cambiando de página populares
  bool _cargando = false;

  List<Pelicula> _populares = new List(); //Lista de peliculas para usar STREAM

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  
  //GETTERS
  //Funcion wue recibe una lista de peliculas, para ser enviada por el Stream mediante SINK
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  //Método para cerrar el Stream
  void disposeStreams(){ 
    _popularesStreamController?.close();
  }


  Future <List<Pelicula>> getEnCines()async{

    //Uri = Widget para trabajar con https
    final url = Uri.https(_url,'3/movie/now_playing',{

      'api_key' : _apikey,
      'language' : _language

    });

    return await _procesarRespuesta(url);

  }

  Future <List<Pelicula>> getPopulares() async {
    //Si no se encuentra cargando peliculas, devuelve nada
    if( _cargando) return [];
    _cargando = true;
    _popularesPage ++; //Aumentamos el  numero de la página que queremosir cargando cada vez que se llama al método getPopulares
    
    //print('cargando siguientes...'); Cargaba todo el rato las peliculas

    //Uri = Widget para trabajar con https
    //Servicio llamada http que regresa lista de peliculas
    final url = Uri.https(_url,'3/movie/popular',{

      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : _popularesPage.toString(),

    });

    final resp = await _procesarRespuesta(url);
    //----------------------------------------------------------------

    _populares.addAll(resp); //Añadimos a la lista de populares todas las peliculas
    popularesSink(_populares); //Enviamos las peliculas al STREAM para que las "escuche"
    _cargando = false; //Cambiamos la variable _cargando
    return resp; //Retornamos las peliculas
  }

  Future <List<Actor>>getCast(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/credits', {

      'api_key'   : _apikey,
      'language'  : _language,
    });

    final resp = await http.get(url);
        //Mapa de la peticion http: resp
    final Map decodedData = jsonDecode(resp.body);
    //Pasamos el mapa a lista con el método definido en la clase Cast de actores model
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    //El constructor Peliculas.fromJsonMap barre toda la información y la guarda en peliculas
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    

    return peliculas.items;    

  }

  Future <List<Pelicula>> buscarPelicula(String query)async{

  //Uri = Widget para trabajar con https
  final url = Uri.https(_url,'3/search/movie',{

    'api_key'  : _apikey,
    'language' : _language,
    'query'    : query

  });

      return await _procesarRespuesta(url);
  }

}