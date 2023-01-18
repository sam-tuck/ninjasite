import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/admin_viewpage.dart';
import 'package:jsninja/user_viewpage.dart';

//final adminCheck = Provider((ref) => ref.watch(docSP('admin/$uid')).data((doc) => doc.exists));
final adminDoc = FutureProvider((_) async {
  // Get the current user's UID
  final user = await FirebaseAuth.instance.currentUser!;
  final uid = user.uid;

  // Get the document for the current user from the 'admins' collection
  final doc = FirebaseFirestore.instance.collection('admins').doc(uid);
  // print ('User Id is $uid');
  // print (doc.get());
  // Use the `get()` method to check if the document exists
  return doc.get();
});

class ChooseUserViewWidget extends ConsumerWidget {
  const ChooseUserViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
    ref.watch(adminDoc).when(
      loading: () => Container(),
      error: (e, s) => ErrorWidget(e),
      // Following code for actual admin view or user view
      // data: (doc) => (doc.exists)? const AdminViewWidget() : const UserViewWidget()
       
       /*Workaround way just to show admin or user view using dummy button
        By default UserView Widget will be shown*/
      data:(doc) => const UserViewWidget(),

    );
  }

