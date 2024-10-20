import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Model/movie/index.dart';
import 'package:movieapp/bloc/movie/states.dart';
import 'package:movieapp/bloc/movie/events.dart';
import 'package:movieapp/global_keys.dart';
import 'package:movieapp/providers/common.dart';
import 'package:movieapp/services/api/index.dart';
import 'package:provider/provider.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieGetAll>((event, emit) async {
      if (Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
              listen: false)
          .movies
          .isNotEmpty) {
        emit(MovieLoading());
        try {
          final api = ApiService();
          final res = await api.getRequest("/6713b7ebe41b4d34e4457808", true);
          print(res.data);
          List<MovieModel> data = MovieModel.fromList(res.data['record']);
          Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
                  listen: false)
              .setMovies(data);
          emit(MovieSuccess());
        } catch (ex) {
          emit(MovieFailure(ex.toString()));
        }
      }
    });

    on<MovieGetInfo>((event, emit) async {
      emit(MovieLoading());
      try {
        final api = ApiService();
        final res = await api.getRequest("/6714787bacd3cb34a899f0fe", true);
        print(res.data);
        MovieModel data = MovieModel.fromJson(res.data['record']);

        emit(MovieSuccessDetail(data));
      } catch (ex) {
        emit(MovieFailure(ex.toString()));
      }
    });
  }
}
