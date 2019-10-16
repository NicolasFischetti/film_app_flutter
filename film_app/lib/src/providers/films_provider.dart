import 'dart:async';

import 'package:film_app/src/models/actors_model.dart';
import 'package:film_app/src/models/film_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FilmsProvider {
  String _apikey = '1cfd9636fb5e1d9902ac2fc6071615c7';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';
  int _popularPage = 0;
  bool _loading = false;

  List<Film> _popular = new List();

  final _popularStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Film>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Film>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final films = new Films.fromJsonList(decodeData['results']);

    return films.items;
  }
  

  Future<List<Film>> getInCinema() async {

      final url = Uri.https(_url, '3/movie/now_playing', {
        'api_key' : _apikey,
        'language' : _language
    });

    return await _processResponse(url);

   }

  Future<List<Film>> getPopular() async {

      if(_loading) return [];

      _loading = true;

      _popularPage++;

      final url = Uri.https(_url, '3/movie/popular', {
        'api_key' : _apikey,
        'language' : _language,
        'page'     : _popularPage.toString()
    });

    final resp = await _processResponse(url);

    _popular.addAll(resp);

    popularSink(_popular);

    _loading = false;

    return resp;

   }

  Future<List<Actor>> getCast(String filmId) async {
    final url = Uri.https(_url, '3/movie/$filmId/credits', {
       'api_key' : _apikey,
       'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;

  }

   Future<List<Film>> searchFilm(String query) async {

      final url = Uri.https(_url, '3/search/movie', {
        'api_key' : _apikey,
        'language' : _language,
        'query'    : query
    });

    return await _processResponse(url);

   }
}

