
//Clase Peliculas
class Peliculas{

  List<Pelicula> items = new List();

  Peliculas();
//Constructor que coge la información de las peliculas del json
  Peliculas.fromJsonList(List<dynamic> jsonList){

    if(jsonList == null) return; 

    for (var item in jsonList) {
      
      final pelicula = new Pelicula.fromJsonMap(item); //Pelicula = Un nuevo mapa con todos los campos del json
      items.add(pelicula); //Añadimos cada item(cada conjunto de info en el json), a lavariable pelicula
    }

  }

}

// Generated by https://quicktype.io
//Generado por funcion Json to code

class Pelicula {

  String uniqueID; //Id generado para poder hacer la transicion si una peli está en el cine y es popular a la vez

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

//Mapa que coge la informacion del json
  Pelicula.fromJsonMap(Map<String,dynamic> json){

    popularity          = json['popularity'] / 1;
    voteCount           = json['vote_count'];
    video               = json['video'];
    posterPath          = json['poster_path'];
    id                  = json['id'];
    adult               = json['adult'];
    backdropPath        = json['backdrop_path'];
    originalLanguage    = json['original_language'];
    originalTitle       = json['original_title'];
    genreIds            = json['genre_ids'].cast<int>();
    title               = json['title'];
    voteAverage         = json['vote_average'] / 1;
    overview            = json['overview'];
    releaseDate         = json['release_date'];

  }

  getPosterImg(){

    if(posterPath == null){
      return 'https://www.bengi.nl/wp-content/uploads/2014/10/no-image-available1.png';

    } else{
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

    getBackgroundImg(){

    if(posterPath == null){
      return 'https://www.bengi.nl/wp-content/uploads/2014/10/no-image-available1.png';

    } else{
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}