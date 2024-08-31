part of 'all_movie_bloc.dart';

abstract class AllMovieState extends Equatable {
  const AllMovieState();

  @override
  List<Object> get props => [];
}

class AllMovieInitial extends AllMovieState {}

class AllMovieLoading extends AllMovieState {}

class AllMovieLoaded extends AllMovieState {
  final List<Movie> listMovie;
  const AllMovieLoaded(this.listMovie);
}

class AllMovieError extends AllMovieState {
  final String error;
  const AllMovieError(this.error);
}
