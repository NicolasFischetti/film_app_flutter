import 'package:film_app/src/models/actors_model.dart';
import 'package:film_app/src/models/film_model.dart';
import 'package:film_app/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class FilmDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(film),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitle(context, film),
                _description(film),
                _createCasting(film)
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _createAppBar(Film film) {
    film.getBackgroundImg();
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          film.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(film.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
              tag: film.uniqueId,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                child: Image(
                image: NetworkImage(film.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(film.title, 
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                ),
                Text(film.originalTitle, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(film.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

 Widget _description(Film film) {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
     child: Text(
       film.overview,
       textAlign: TextAlign.justify,
     ),
   );
 }

 Widget _createCasting(Film film) {
   final filmProvider = new FilmsProvider();

   return FutureBuilder(
     future: filmProvider.getCast(film.id.toString()),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
     },
   );
 }

  Widget _createActorsPageView(List<Actor> actors) {
      return SizedBox(
        height: 200.0,
        child: PageView.builder(
          pageSnapping: false,
          itemCount: actors.length,
          controller: PageController(
            viewportFraction: 0.3,
            initialPage: 1
          ),
          itemBuilder: (context, i) {
            return _actorCard(actors[i]);
          },
        ),
      );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}