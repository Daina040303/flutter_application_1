import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  bool _isPinMode = false;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.6895, 139.6917),
    zoom: 10,
  );

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(LatLng position) {
    final marker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: position,
      infoWindow: InfoWindow(title: '思い出地点'),//ピンのタイトルを表示
    );

    setState(() {
      _markers.add(marker);
    });

    //Firestoreに保存する処理を追加 保存したい情報（座標,刺した人,タイトル）
  }

  void _togglePinMode() {
    setState(() {
      _isPinMode = !_isPinMode;
    });

    final message = _isPinMode ? 'ピン差しモードON' : 'ピン差しモードOFF';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('思い出マップ')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            markers: _markers,
            onLongPress: _isPinMode ? _addMarker : null,
            scrollGesturesEnabled: !_isPinMode,
            zoomGesturesEnabled: !_isPinMode,
            rotateGesturesEnabled: !_isPinMode,
            tiltGesturesEnabled: !_isPinMode,
          ),

          // ピン差しモード時のフレーム
          if (_isPinMode)
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent, width: 4),
                  color: Colors.red.withOpacity(0.05),
                ),
                child: Center(
                  child: Text(
                    'ピン差しモード',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePinMode,
        child: Icon(_isPinMode ? Icons.edit_location_alt : Icons.edit),
        tooltip: 'ピン差しモード切替',
      ),
    );
  }
}
