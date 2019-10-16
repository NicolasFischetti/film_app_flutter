import 'package:film_app/src/models/film_model.dart';
import 'package:film_app/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  String select = "";
  final filmsProviders = new FilmsProvider();

  final films = [
    "Spiderman1",
    "Capitan America1",
    "Spiderman2",
    "Capitan America2",
    "Spiderman3",
    "Capitan America3"
  ];

  final newFilms = [
    "Spiderman",
    "Capitan America"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions appbar(to clean search)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon left appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder results to show
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions when the user write something

    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: filmsProviders.searchFilm(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if(snapshot.hasData) {

          final films = snapshot.data;

          return ListView(
            children: films.map((film) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(film.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(film.title),
                subtitle: Text(film.originalTitle),
                onTap: () {
                  close(context, null);
                  film.uniqueId = "";
                  Navigator.pushNamed(context, 'detail', arguments: film);
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

  /*  final listSuggestead = (query.isEmpty) ? newFilms : films.where(
      (p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listSuggestead.length,
      itemBuilder: (context, i) => ListTile(
        onTap: () {
          select = listSuggestead[i];
          showResults(context);
        },
        leading: Icon(Icons.movie),
        title: Text(listSuggestead[i]),
      ),
    );
  } */

  }
}