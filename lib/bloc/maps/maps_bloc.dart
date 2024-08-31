import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsInitial()) {
    on<FetchCurrentLocation>((event, emit) async {
      emit(MapsLoading());
      try {
        final status = await Permission.location.request();
        if (status.isGranted) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          emit(MapsLoaded(LatLng(position.latitude, position.longitude)));
        } else if (status.isPermanentlyDenied) {
          openAppSettings();
        }
      } catch (e) {
        emit(MapsError(e.toString()));
      }
    });
  }
}
