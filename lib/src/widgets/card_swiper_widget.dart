import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class CardSwiperWidget extends StatelessWidget {

  final List<Pelicula> peliculas; //Lista de las peliculas
  //Le decimos al constructor que la lista de las peliculas es obligatoria con @required
  CardSwiperWidget({  @required this.peliculas});

  @override
  Widget build(BuildContext context) {
                        //Contiene la información del dispositivo. RESPONSIVE
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      //Dependencia instalada: https://pub.dev/packages/flutter_swiper
      child: Swiper(
        //FALTA INFO EN LA DOCUMENTACIÓN
        //Es necesario especificar las dimensiones(Metemos dentro de un container)
        itemCount: 20, //Numero de items que queremos ver
        itemWidth: _screenSize.width * 0.7, //Anchura del item
        itemHeight: _screenSize.height * 0.5, //Altura delitem
        layout: SwiperLayout.STACK, //Como queremos ver el swiper/Estilo del swiper
        itemBuilder: (BuildContext context,int index){
          //Devuelve una imagen de esa direccion que ocupa todo el hueco posible
          peliculas[index].uniqueID = '${peliculas[index].id}-tarjeta';
          
          return Hero(
            tag: peliculas[index].uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        
        //pagination: new SwiperPagination(), 'flechitas para deslizar'
        //control: new SwiperControl(), 'bolita para deslizar'
      ),
    );   
  }
}

