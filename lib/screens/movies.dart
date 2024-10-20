import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/bloc.dart';
import 'package:movieapp/bloc/movie/events.dart';
import 'package:movieapp/bloc/movie/states.dart';
import 'package:movieapp/providers/common.dart';
import 'package:movieapp/widgets/movie_card.dart';
import 'package:movieapp/widgets/movie_special_card.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final _bloc = MovieBloc();
  bool _loading = false;
  bool _error = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(MovieGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieBloc, MovieState>(
          bloc: _bloc,
          listener: ((context, state) {
            if (state is MovieLoading) {
              setState(() {
                _loading = true;
                _error = false;
              });
            }
            if (state is MovieSuccess) {
              
              setState(() {
                _loading = false;
              });
            }
            if (state is MovieFailure) {
              setState(() {
                _loading = false;
                _error = false;
              });
            }
          }),
        ),
      ],
      child: Consumer<CommonProvider>(
        builder: ((context, provider, child) {
          return _loading
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "top".tr(),
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
                          children: provider.specialData
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
                          "all".tr(),
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
                            children: List.generate(
                                provider.movies.length,
                                (index) => MovieCard(
                                      provider.movies[index],
                                    ))),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
