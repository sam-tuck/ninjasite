import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/app_bar.dart';
import 'package:jsninja/common.dart';
import 'package:jsninja/search/search_details.dart';
import 'package:jsninja/search/vacancy_list.dart';
import 'package:jsninja/state/generic_state_notifier.dart';
import 'package:jsninja/drawer.dart';
import 'package:http/http.dart' as http;

import '../vacancies/user_vacancy_search_list.dart';

final activeBatch =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class VacanciesPage extends ConsumerWidget {
  final TextEditingController searchCtrl = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar.getBar(context, ref),
      drawer: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
          ? TheDrawer.buildDrawer(context)
          : null,
      body: Container(
          margin: EdgeInsets.all(100),
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white),
                          style: TextStyle(height: 15 / 10),
                          onChanged: (v) {},
                          controller: searchCtrl)),
                  SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                      child: Text(
                        "Add",
                        // style: Theme.of(context).textTheme.headline3,
                      ),
                      onPressed: () async {
                        if (searchCtrl.text.isEmpty) return;

                        var col = await FirebaseFirestore.instance
                            .collection(
                                'user/${FirebaseAuth.instance.currentUser!.uid}/vacancy')
                            .where('url', isEqualTo: searchCtrl.text)
                            .get();
                        if (col.size > 0) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content:
                                      Text('This job has already been added.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    )
                                  ],
                                );
                              });
                          print('already exists');
                          return;
                        }

                        FirebaseFirestore.instance
                            .collection(
                                'user/${FirebaseAuth.instance.currentUser!.uid}/vacancy')
                            // .doc(FirebaseAuth
                            //     .instance.currentUser!.uid)
                            // .collection('search')
                            .add({
                          'url': searchCtrl.text,
                          'timeCreated': FieldValue.serverTimestamp(),
                          'author': FirebaseAuth.instance.currentUser!.uid,
                        });
                        var vac = await FirebaseFirestore.instance
                            .collection(
                                'user/${FirebaseAuth.instance.currentUser!.uid}/vacancy')
                            .where('url', isEqualTo: searchCtrl.text)
                            .get();
                        FirebaseFirestore.instance
                            .collection(
                                'user/${FirebaseAuth.instance.currentUser!.uid}/application')
                            .add({
                          'timeCreated': FieldValue.serverTimestamp(),
                          'vacancy':
                              'user/${FirebaseAuth.instance.currentUser!.uid}/vacancy/${vac.docs[0].id}'
                        });
                      })
                ],
              ),
              UserVacanciesList(uid),
            ],
          )),
    );
  }
}

// buildAddBatchButton(BuildContext context, WidgetRef ref) {
//   TextEditingController id_inp = TextEditingController();
//   TextEditingController name_inp = TextEditingController();
//   TextEditingController desc_inp = TextEditingController();
//   return ElevatedButton(
//     child: Text("Add Batch"),
//     onPressed: () {
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               scrollable: true,
//               title: Text('Adding Batch...'),
//               content: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Form(
//                   child: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         controller: id_inp,
//                         decoration: InputDecoration(labelText: 'ID'),
//                       ),
//                       TextFormField(
//                         controller: name_inp,
//                         decoration: InputDecoration(
//                           labelText: 'Name',
//                         ),
//                       ),
//                       TextFormField(
//                         controller: desc_inp,
//                         decoration: InputDecoration(
//                           labelText: 'Description',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                     child: Text("Submit"),
//                     onPressed: () {
//                       FirebaseFirestore.instance.collection('batch').add({
//                         'id': id_inp.text.toString(),
//                         'name': name_inp.text.toString(),
//                         'desc': desc_inp.text.toString(),
//                         'time Created': FieldValue.serverTimestamp(),
//                         'author': FirebaseAuth.instance.currentUser!.uid,
//                       }).then((value) => {
//                             if (value != null)
//                               {FirebaseFirestore.instance.collection('batch')}
//                           });

//                       Navigator.of(context).pop();
//                     })
//               ],
//             );
//           });
//     },
//   );
// }

