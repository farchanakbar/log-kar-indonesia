import 'package:equatable/equatable.dart';
import 'package:log_kar_indonesia/bloc/export.dart';

part 'all_movie_event.dart';
part 'all_movie_state.dart';

class AllMovieBloc extends Bloc<AllMovieEvent, AllMovieState> {
  MovieProvider movieProvider;
  AllMovieBloc(this.movieProvider) : super(AllMovieInitial()) {
    on<FetchAllMovie>(
      (event, emit) async {
        emit(
          AllMovieLoading(),
        );
        try {
          final result = await movieProvider.getAllMovie();
          emit(
            AllMovieLoaded(result),
          );
        } catch (e) {
          emit(
            AllMovieError(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}
