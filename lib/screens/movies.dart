import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/Model/movie/index.dart';
import 'package:movieapp/widgets/movie_card.dart';
import 'package:movieapp/widgets/movie_special_card.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Future<List<MovieModel>> _getData() async {
    try {
      String res =
          await DefaultAssetBundle.of(context).loadString("assets/movies.json");
      return MovieModel.fromList(jsonDecode(res));
    } catch (error) {
      // Handle error, e.g., show error message or return empty list
      print('Error fetching data: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<MovieModel>>(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final List<MovieModel> movies = snapshot.data!;
          final List<MovieModel> specialData =
              movies.length > 3 ? movies.sublist(0, 3) : movies;

          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Шилдэг кино",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: specialData
                      .map((movie) => MovieSpecialCard(movie))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Бүх кинонууд",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: List.generate(snapshot.data!.length,
                        (index) => MovieCard(snapshot.data![index]))),
              ),
            ],
          ));
        } else {
          return Center(
            child: Text('No data found!'),
          );
        }
      },
    );
  }
}
