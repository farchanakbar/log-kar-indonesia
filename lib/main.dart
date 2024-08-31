import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:log_kar_indonesia/app.dart';
import 'package:log_kar_indonesia/general_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyObserver();
  runApp(const App());
}
