


import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';



class DataSearch extends SearchDelegate{

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Capitan America',
    'Shazam',
    'Batman',
    'Aquaman',
    'Ironman',
  ];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
      //Acciones de nuestro Appbar. Limpiar busqueda/Cancelar busqueda,etc
      return[
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = ''; //Borra la caja de texto
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      //Contenido que aparece en la izquierda del Appbar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation, //Transición por defecto
        ), 
        onPressed: (){
          close(context, null); //Volver hacia atrás sin enviar nada
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      //Crea los resultados que vamos a mostrar
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text(seleccion),
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot <List<Pelicula>>snapshot) {
        if(snapshot.hasData){

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula){ //Convertir el listado de peliculas en un listado de Widgets
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-img.jpg'),
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueID = '';
                  Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                },
              );
            }).toList(),
          );

        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}