import 'package:equatable/equatable.dart';
import 'package:movieapp/Model/movie/index.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  const MovieInitial();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {
  const MovieLoading();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieSuccess extends MovieState {
  const MovieSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieSuccessDetail extends MovieState {
  final MovieModel data;
  const MovieSuccessDetail(this.data);

  @override
  List<Object?> get props => [];
}

class MovieFailure extends MovieState {
  final String message;

  MovieFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
