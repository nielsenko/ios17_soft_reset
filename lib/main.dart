import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

part 'main.g.dart';

@RealmModel()
class _Stuff {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
}

final realm = Realm(Configuration.local([Stuff.schema]));

Future<void> main() async {
  Isolate.run(() {
    while (true) {
      realm.write(() => realm.add(Stuff(ObjectId())));
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: realm.all<Stuff>().changes,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return data == null
              ? const CircularProgressIndicator()
              : Material(
                  child: Center(child: Text('length: ${data.results.length}')),
                );
        },
      ),
    );
  }
}
