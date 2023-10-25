import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:realm/realm.dart';

part 'main.g.dart';

@RealmModel()
class _Stuff {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
}

Future<Realm> initRealm = () async {
  // don't trust realm to get path right in debug mode on iOS 17..
  final dir = await pp.getApplicationDocumentsDirectory();
  return Realm(Configuration.local(
    [Stuff.schema],
    path: '${dir.path}/my.realm',
  ));
}();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Isolate.spawn((token) async {
    // for path_provider package
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);

    final realm = await initRealm;
    while (true) {
      await realm.writeAsync(() => realm.add(Stuff(ObjectId())));
    }
  }, ServicesBinding.rootIsolateToken!);

  runApp(MyApp(realm: await initRealm));
}

class MyApp extends StatelessWidget {
  final Realm realm;
  const MyApp({super.key, required this.realm});

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
