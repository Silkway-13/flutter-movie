import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Model/movie/index.dart';
import 'package:movieapp/bloc/movie/bloc.dart';
import 'package:movieapp/bloc/movie/events.dart';
import 'package:movieapp/bloc/movie/states.dart';
import 'package:movieapp/providers/common.dart';
import 'package:movieapp/utils/index.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage(this.id, {super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _bloc = MovieBloc();
  MovieModel? data;
  bool _loading = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!Provider.of<CommonProvider>(context, listen: false).isLoggedIn) {
        Provider.of<CommonProvider>(context, listen: false).changeCurrentIdx(2);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('нэвтэрнэ үү!')));
        Navigator.pop(context);
      } else {
        _bloc.add(MovieGetInfo(data!.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
              if (state is MovieSuccessDetail) {
                setState(() {
                  data = state.data;
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
        child: Consumer<CommonProvider>(builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 34, 36, 40),
            body: _loading || data == null
                ? Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      // SliverAppBar(x
                      //   title: Text(data.title),
                      // ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Stack(
                              // fit: StackFit.expand,
                              children: [
                                Image.network(
                                  data!.imgUrl,
                                  width: width,
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.play_circle,
                                        color: Colors.grey.withOpacity(0.9),
                                        size: 60,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        data!.title,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${data!.publishedYear} | ${Utils.integerMinToString(data!.durationMin)} | ${data!.type}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                ),
                                SafeArea(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () =>
                                          provider.addWishList(widget.id),
                                      icon: Icon(
                                        provider.isWishMovie(data!)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Тайлбар",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data!.description ?? " ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          );
        }));
  }
}
