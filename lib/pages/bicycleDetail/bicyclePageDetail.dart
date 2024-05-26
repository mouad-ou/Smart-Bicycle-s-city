// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/bicycle.dart';
import '../QRScanPage/QRScanPage.dart'; // Import the QRScanPage page

class bicycleDetailsPage extends StatefulWidget {
  final String? bicycleId;
  const bicycleDetailsPage({Key? key, this.bicycleId}) : super(key: key);

  @override
  _BicycleDetailsPageState createState() => _BicycleDetailsPageState();
}

class _BicycleDetailsPageState extends State<bicycleDetailsPage> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  LatLng? _initialPosition;

  @override
  void initState() {
    super.initState();
    _fetchBicycleData();
  }

  Future<void> _fetchBicycleData() async {
    if (widget.bicycleId != null) {
      var doc = await FirebaseFirestore.instance.collection('bicycles').doc(widget.bicycleId).get();
      var locationParts = doc['location'].split(',');
      var lat = double.parse(locationParts[0]);
      var lng = double.parse(locationParts[1]);
      _initialPosition = LatLng(lat, lng);
      _markers.add(
        Marker(
          markerId: MarkerId('locationMarker'),
          position: _initialPosition!,
        ),
      );
      setState(() {}); // Refresh the UI
    }
  }

  void _launchMaps() async {
    if (_initialPosition != null) {
      final url = 'https://www.google.com/maps/search/?api=1&query=${_initialPosition!.latitude},${_initialPosition!.longitude}';
      try {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      } catch (e) {
        print('Error launching URL: $e');
      }
    }
  }

  void _navigateToBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRScanPage(bookedBicycle: Bicycle(id: widget.bicycleId))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialPosition != null ? GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition!,
          zoom: 11.0,
        ),
        markers: _markers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ) : Center(child: CircularProgressIndicator()),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                onPressed: _launchMaps,
                label: Text('Direction '),
                icon: Icon(Icons.directions_bike_outlined),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                onPressed: _navigateToBooking, // Change this line
                label: Text('Book Now'),
                icon: Icon(Icons.book_online_outlined),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}