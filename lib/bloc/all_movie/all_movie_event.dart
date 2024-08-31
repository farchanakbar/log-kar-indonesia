part of 'all_movie_bloc.dart';

abstract class AllMovieEvent extends Equatable {
  const AllMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchAllMovie extends AllMovieEvent {}
