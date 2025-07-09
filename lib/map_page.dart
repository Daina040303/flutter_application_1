import 'package:flutter/material.dart';
import 'dart:convert';          // jsonEncode, jsonDecode を使うため
import 'package:http/http.dart' as http;  // HTTP通信を行うため
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  bool _isPinMode = false;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(35.6895, 139.6917),//東京の座標
    zoom: 10,
  );

  void test() async{
      final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/test'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': 'Hello Server'
      }),
    );

    print('ステータス: ${response.statusCode}');
    print('レスポンス: ${response.body}');

  }

  @override
  void initState() {
    super.initState();
    test(); // ← ここで呼test()を初回実行
    _fetchMarkersFromServer(); // ← メモリ取得
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _showPinInfoDialog(LatLng position) {
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _nameController = TextEditingController();
    String _selectedDate = DateTime.now().toIso8601String().split('T')[0]; // 初期値：今日

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('思い出を記録', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'タイトル'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: '思い出・コメント'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '名前（ピンの作成者）'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('日付: $_selectedDate'),
                Spacer(),
                TextButton(
                  child: Text('日付選択'),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked.toIso8601String().split('T')[0];
                      });
                    }
                  },
                )
              ],
            ),
            ElevatedButton(
              child: Text('保存'),
              onPressed: () {
                Navigator.pop(context); // モーダルを閉じる
                _addMarkerWithInfo(
                  position,
                  _titleController.text,
                  _descriptionController.text,
                  _selectedDate,
                  _nameController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addMarkerWithInfo(
    LatLng position,
    String title,
    String description,
    String date,
    String createdBy,
  ) async{
    final marker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: position,
      infoWindow: InfoWindow(title: title, snippet: '$description\nby $createdBy ($date)'),
    );

    setState(() {
      _markers.add(marker);
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/memories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'lat': position.latitude,//ピン座標➀
        'lng': position.longitude,//ピン座標➁
        'title': title,//タイトル
        'description': description,//思い出、コメント
        'date': date,//思い出の日付
        'createdBy': createdBy,//ピンの作成者
      }),
    );

    if (response.statusCode == 201) {
      print('保存成功');
    } else {
      print('保存失敗: ${response.body}');
    }
  }

  Future<void> _fetchMarkersFromServer() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/api/memories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> memories = jsonDecode(response.body);

        setState(() {
          _markers.clear(); // 一度全削除（必要に応じて）
          for (var memory in memories) {
            final marker = Marker(
              markerId: MarkerId(memory['_id']),
              position: LatLng(memory['lat'], memory['lng']),
              infoWindow: InfoWindow(
                title: memory['title'],
                snippet: '${memory['description']}\nby ${memory['createdBy']} (${memory['date']})',
              ),
            );
            _markers.add(marker);
          }
        });
      } else {
        print('ピン取得失敗: ${response.body}');
      }
    } catch (e) {
      print('エラー: $e');
    }
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
            onLongPress: _isPinMode ? _showPinInfoDialog : null,
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
                  child: Text(//モードがわかりやすいように表示しているだけ
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
      floatingActionButton: FloatingActionButton(//ピン差しモード中はキャンセルボタンみたいに表示
        onPressed: _togglePinMode,
        child: Icon(_isPinMode ? Icons.cancel : Icons.add_location),
        tooltip: 'ピン差しモード切替',
      ),
    );
  }
}
