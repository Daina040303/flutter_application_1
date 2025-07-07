/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createGroup(String name) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('ログインしていません');

    final groupRef = await _firestore.collection('groups').add({
      'name': name,
      'createdBy': uid,
      'members': [uid],
    });

    // ユーザーにも参加グループ情報を追加（オプション）
    await _firestore.collection('users').doc(uid).set({
      'groups': FieldValue.arrayUnion([groupRef.id]),
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getUserGroups() {
    final uid = _auth.currentUser?.uid;
    return _firestore
        .collection('groups')
        .where('members', arrayContains: uid)
        .snapshots();
  }
}
*/
