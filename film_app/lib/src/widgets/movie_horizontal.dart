import 'package:film_app/src/models/film_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {

 final List<Film> films;
 final Function nextPage;

 MovieHorizontal({@required this.films, @required this.nextPage});

 final _pageController = new PageController(
   initialPage: 1,
   viewportFraction: 0.3,
 );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      } 
    });
    

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
       pageSnapping: false,
       controller:  _pageController,
      // children: _cards(context)
       itemCount: films.length,
       itemBuilder: (BuildContext context, i) {
         return _card(context, films[i]);
       },
      ),
    );
  }

  Widget _card(BuildContext context, Film film) {

     film.uniqueId = '${film.id}--poster';

    final filmCard = Container(
       margin: EdgeInsets.only(right: 20.0),
         child: Column(
           children: <Widget>[
             Hero(
                tag: film.uniqueId,
                child: ClipRRect(
                 borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                   image: NetworkImage(film.getPosterImg()),
                   placeholder: AssetImage('assets/img/no-image.jpg'),
                   fit: BoxFit.cover,
                   height: 150.0,
                 ),
               ),
             ),
             SizedBox(height: 10.0),
             Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   SizedBox(
                     width: 120.0,
                     child: Text(
                      film.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                   ),
                  )
                 ],
               ),
             ),
           ],
         ),
       );

       return GestureDetector(
         child: filmCard,
         onTap: () {
           Navigator.pushNamed(context, 'detail', arguments: film);
         },
       );
  }

 /* List<Widget> _cards(BuildContext context) {
    return films.map((film) {
       return Container(
       margin: EdgeInsets.only(right: 20.0),
         child: Column(
           children: <Widget>[
             ClipRRect(
               borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                 image: NetworkImage(film.getPosterImg()),
                 placeholder: AssetImage('assets/img/no-image.jpg'),
                 fit: BoxFit.cover,
                 height: 150.0,
               ),
             ),
             SizedBox(height: 10.0),
             Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   SizedBox(
                     width: 120.0,
                     child: Text(
                      film.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                   ),
                  )
                 ],
               ),
             ),
           ],
         ),
       );
    }).toList();
  } */
}