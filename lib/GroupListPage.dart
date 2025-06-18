import 'package:flutter/material.dart';
import 'package:flutter_application_1/GroupCreatePage.dart';
import 'package:flutter_application_1/map_page.dart';
import 'groups_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (!authSnapshot.hasData) {
            return Center(child: Text('ログインが必要です'));
          }

          return StreamBuilder(
            stream: _service.getUserGroups(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

              //final docs = snapshot.data!.docs;
              final docs = "グループ名";
              if (docs.isEmpty) return Center(child: Text('まだグループがありません'));

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final group = docs[index];
                  return ListTile(
                    //title: Text(group['name']),
                    title: Text("グループ名"),
                    onTap: () {
                      /* 今後、詳細画面に遷移予定
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MapPage()),
                      );*/
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
