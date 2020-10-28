import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';



class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  //Declaramos esta funcion para pasarla por parametro, ya que es de otra clase
  final Function siguientePagina;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

                  //Estos atributos son requeridospara realizar todolo de esta clase
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) 
        siguientePagina(); //Llamamos al método de cargar peliculas del 
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
      //children: _tarjetas(context),
      itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index){
        return _crearTarjeta(peliculas[index], context);
        },
      ),
    );
  }

  Widget _crearTarjeta(Pelicula pelicula, BuildContext context){

    pelicula.uniqueID = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero( //Animación de transaccion de imagenes 
            tag: pelicula.uniqueID, //Un id para enlazar los dos Hero
            child: ClipRRect( //Redondear containers
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fadeInDuration: Duration(seconds: 2),
                fit: BoxFit.cover,
                height: 100.0,  //Altura de las tarjetas
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis, //Puntos suspensivos cuando no cabe el texto
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
    return GestureDetector(  //Detector de gestos
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }


/*   List<Widget> _tarjetas(BuildContext context){
    //Hacemos iterable las peliculas.
    return peliculas.map( (pelicula) {
      //Por cada pelicula, devuelve este container
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect( //Redondear containers
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fadeInDuration: Duration(seconds: 2),
                fit: BoxFit.cover,
                height: 100.0,  //Altura de las tarjetas
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis, //Puntos suspensivos cuando no cabe el texto
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

    }).toList(); //Lo convierte en lista de nuevo

  } */
}