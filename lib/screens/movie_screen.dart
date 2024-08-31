import 'package:flutter/material.dart';
import 'package:log_kar_indonesia/bloc/export.dart';
import 'package:log_kar_indonesia/bloc/movie/movie_bloc.dart';
import 'package:log_kar_indonesia/data/providers/movie_provider.dart';

class MovieScreen extends StatelessWidget {
  final int id;
  const MovieScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    MovieBloc movieB = context.read<MovieBloc>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/$id.jpg',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<MovieBloc, MovieState>(
              bloc: movieB,
              builder: (context, state) {
                if (state is MovieInitial) {
                  movieB.add(FetchMovie(id));
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieLoaded) {
                  final movie = state.movie;
                  String dateString =
                      '${movie.releaseDate}'; // Format string tanggal
                  DateTime dateTime = DateTime.parse(
                      dateString); // Mengubah string menjadi DateTime
                  int year = dateTime.year;

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        '${movie.title}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$year'),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 15,
                            width: 1,
                            color: Colors.white,
                          ),
                          Text('${movie.director}'),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 15,
                            width: 1,
                            color: Colors.white,
                          ),
                          Text('${movie.episodeId} Eps')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Berlangganan Untuk Menonton S1 E1')
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Producer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text('${movie.producer}'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text('${movie.openingCrawl}'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Characters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: MovieProvider().characters(movie.characters),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(
                                'Loading..',
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('tidak ada data'),
                            );
                          }
                          final data = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 18,
                            ),
                            itemBuilder: (context, index) {
                              return Text('${data[index].name}');
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Planets',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: MovieProvider().planets(movie.planets),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(
                                'Loading..',
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('tidak ada data'),
                            );
                          }
                          final data = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 18,
                            ),
                            itemBuilder: (context, index) {
                              return Text('${data[index].name}');
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Starships',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: MovieProvider().starships(movie.starships),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(
                                'Loading..',
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('tidak ada data'),
                            );
                          }
                          final data = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 18,
                            ),
                            itemBuilder: (context, index) {
                              return Text('${data[index].name}');
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Vehicles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: MovieProvider().vehicles(movie.vehicles),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(
                                'Loading..',
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('tidak ada data'),
                            );
                          }
                          final data = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 18,
                            ),
                            itemBuilder: (context, index) {
                              return Text('${data[index].name}');
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Species',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      FutureBuilder(
                        future: MovieProvider().species(movie.species),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(
                                'Loading..',
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('tidak ada data'),
                            );
                          }
                          final data = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 18,
                            ),
                            itemBuilder: (context, index) {
                              return Text('${data[index].name}');
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                } else if (state is MovieError) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
