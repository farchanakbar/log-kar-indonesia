import 'package:flutter/material.dart';
import 'package:log_kar_indonesia/bloc/all_movie/all_movie_bloc.dart';
import 'package:log_kar_indonesia/bloc/maps/maps_bloc.dart';
import 'package:log_kar_indonesia/bloc/movie/movie_bloc.dart';
import 'package:log_kar_indonesia/data/providers/movie_provider.dart';
import 'package:log_kar_indonesia/screens/home_screen.dart';
import './bloc/export.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllMovieBloc(MovieProvider()),
        ),
        BlocProvider(
          create: (context) => MovieBloc(MovieProvider()),
        ),
        BlocProvider(
          create: (context) => MapsBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
