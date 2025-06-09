import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.6895, 139.6917), // 東京（中心にしたい場所）
    zoom: 10,
  );

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: position,
      infoWindow: InfoWindow(title: '思い出地点'),
    );

    setState(() {
      _markers.add(marker);
    });

    // あとで：Firestore に保存する処理をここに追加
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('思い出マップ')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
        markers: _markers,
        onLongPress: _addMarker, // 長押しでマーカー追加
      ),
    );
  }
}
