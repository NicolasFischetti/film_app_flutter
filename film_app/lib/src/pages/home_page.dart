import 'package:film_app/src/providers/films_provider.dart';
import 'package:film_app/src/search/search_delegate.dart';
import 'package:film_app/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:film_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {

    filmsProvider.getInCinema();
    filmsProvider.getPopular();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text("Movies"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
             showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _swiperCards(),
            SizedBox(height: 10.0),
            _footer(context)
          ],
        ),
      ),
    );
  }

 Widget _swiperCards() {

   return FutureBuilder(
     future: filmsProvider.getInCinema(),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
       if(snapshot.hasData) {
           return CardSwiper(films: snapshot.data);
       } else {
         return Container(
           height: 400.0,
           child: Center(
             child: CircularProgressIndicator()));
       }
     },
   );

   /* filmsProvider.getInCinema();

   return CardSwiper(
     films: [1,2,3,4,5],
   ); */
 }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Popular", style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 10.0,),
          StreamBuilder(
            stream: filmsProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
             if(snapshot.hasData) {
               return MovieHorizontal(films: snapshot.data, 
                     nextPage: filmsProvider.getPopular);
             } else {
               return Center(child: CircularProgressIndicator());
             }
            },
          ),
        ],
      ),
    );
  }
  
}