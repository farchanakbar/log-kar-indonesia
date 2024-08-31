part of 'maps_bloc.dart';

abstract class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsLoaded extends MapsState {
  final LatLng position;

  const MapsLoaded(this.position);
}

class MapsError extends MapsState {
  final String message;

  const MapsError(this.message);
}
