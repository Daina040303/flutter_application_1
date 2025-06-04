import 'package:flutter/material.dart';
import 'groups_service.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  _GroupCreatePageState createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  final _controller = TextEditingController();
  final _service = GroupService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('グループ作成')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'グループ名'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _service.createGroup(_controller.text);
                Navigator.pop(context); // 前の画面に戻る
              },
              child: Text('作成する'),
            )
          ],
        ),
      ),
    );
  }
}
