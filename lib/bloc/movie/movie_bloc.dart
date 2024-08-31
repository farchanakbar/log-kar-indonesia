import 'package:equatable/equatable.dart';
import 'package:log_kar_indonesia/bloc/export.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieProvider movieProvider;
  MovieBloc(this.movieProvider) : super(MovieInitial()) {
    on<FetchMovie>((event, emit) async {
      emit(MovieLoading());
      try {
        final result = await movieProvider.getMovieById(event.id);
        emit(MovieLoaded(result));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
