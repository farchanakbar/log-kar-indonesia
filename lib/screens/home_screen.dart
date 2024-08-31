import 'package:flutter/material.dart';
import 'package:log_kar_indonesia/bloc/all_movie/all_movie_bloc.dart';
import 'package:log_kar_indonesia/bloc/export.dart';
import 'package:log_kar_indonesia/screens/google_maps_screen.dart';
import 'package:log_kar_indonesia/screens/movie_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AllMovieBloc allMovieBloc = context.read<AllMovieBloc>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GoogleMapsScreen(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              Text(
                'Maps',
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<AllMovieBloc, AllMovieState>(
        bloc: allMovieBloc,
        builder: (context, state) {
          if (state is AllMovieInitial) {
            allMovieBloc.add(FetchAllMovie());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllMovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllMovieLoaded) {
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[700],
                    ),
                    height: 50,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'Movie',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 9 / 16,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 280),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final movie = state.listMovie[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieScreen(id: index + 1),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[50],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/${index + 1}.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '${movie.title}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is AllMovieError) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}
