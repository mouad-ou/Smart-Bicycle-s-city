import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Stream<QuerySnapshot> getAllLocations() {
    return FirebaseFirestore.instance.collection('bicycles').snapshots();
  }

  void _fetchLocations() {
    getAllLocations().listen((QuerySnapshot snapshot) {
      _markers.clear();
      for (var doc in snapshot.docs) {
        var locationParts = doc['location'].split(',');
        var lat = double.parse(locationParts[0]);
        var lng = double.parse(locationParts[1]);
        _markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(lat, lng),
          ),
        );
      }
      setState(() {}); // Refresh the UI
    });
  }

  void _onMapCreated(GoogleMapController controller) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(31.628674, -7.992047),
          zoom: 13,
        ),
      ),
    );
  }
}