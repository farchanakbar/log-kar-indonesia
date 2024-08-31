import 'dart:async';

import 'package:flutter/material.dart';
import 'package:log_kar_indonesia/bloc/maps/maps_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../bloc/export.dart';

class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MapsBloc mapsB = context.read<MapsBloc>();
    MapboxMapController? mapController;
    String token =
        "sk.eyJ1IjoiZmFyY2hhbmFrYmFyIiwiYSI6ImNtMGd5bTd3NjA0cm4yanBiN2ljanc0aWkifQ.knlWSIpgbShHO-50GZCOBQ";
    LatLng destination = const LatLng(-1.6215813685270346, 103.58701623886718);

    void onMapCreated(MapboxMapController controller) {
      mapController = controller;
    }

    Future<void> navigateToLocation(LatLng position) async {
      final kordinat = await MovieProvider().line([
        LatLng(position.latitude, position.longitude),
        LatLng(destination.latitude, destination.longitude)
      ]);

      mapController?.addLine(LineOptions(
        geometry: kordinat,
        lineColor: "#ff0000",
        lineWidth: 5.0,
      ));

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: destination,
            zoom: 14,
          ),
        ),
      );

      mapController?.addSymbol(SymbolOptions(
        geometry: destination,
        iconImage: "marker-15",
      ));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                  color: Colors.grey[400],
                  child: BlocBuilder<MapsBloc, MapsState>(
                    bloc: mapsB..add(FetchCurrentLocation()),
                    builder: (context, state) {
                      if (state is MapsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (state is MapsLoaded) {
                        return Stack(children: [
                          MapboxMap(
                            accessToken: token,
                            initialCameraPosition: CameraPosition(
                              target: state.position,
                              zoom: 14,
                            ),
                            onMapCreated: (controller) {
                              onMapCreated(controller);
                            },
                            styleString: "mapbox://styles/mapbox/outdoors-v12",
                            myLocationTrackingMode:
                                MyLocationTrackingMode.Tracking,
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      navigateToLocation(state.position);
                                    },
                                    icon: const Icon(
                                      Icons.navigation,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Text(
                                    'Bioskop',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]);
                      } else if (state is MapsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return const SizedBox();
                    },
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          mapsB.add(FetchCurrentLocation());
                        },
                        child: const Text('Posisi Saya')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
