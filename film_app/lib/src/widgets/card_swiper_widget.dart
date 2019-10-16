
import 'package:film_app/src/models/film_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {

  final List<Film> films;

  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
     padding: EdgeInsets.only(top: 10.0),
     child: Swiper(
          itemBuilder: (BuildContext context,int index){

            films[index].uniqueId = '${films[index].id}--cards';

            return Hero(
                tag: films[index].uniqueId,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child:  GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "detail", 
                   arguments: films[index]),
                    child: FadeInImage(
                    image: NetworkImage(films[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          itemCount: films.length,
          itemWidth: _screenSize.width * 0.6,
          itemHeight: _screenSize.height * 0.5,
         // pagination: new SwiperPagination(),
         // control: new SwiperControl(),
          layout: SwiperLayout.STACK,
        ),
   );
  }
}