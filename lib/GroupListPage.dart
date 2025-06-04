import 'package:flutter/material.dart';
import 'package:flutter_application_1/GroupCreatePage.dart';
import 'groups_service.dart';

class GroupListPage extends StatelessWidget {
  final GroupService _service = GroupService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('あなたのグループ'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => GroupCreatePage()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _service.getUserGroups(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return Text('まだグループがありません');

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final group = docs[index];
              return ListTile(
                title: Text(group['name']),
                onTap: () {
                  // 今後、詳細画面に遷移予定
                },
              );
            },
          );
        },
      ),
    );
  }
}
