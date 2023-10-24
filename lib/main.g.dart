// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Stuff extends _Stuff with RealmEntity, RealmObjectBase, RealmObject {
  Stuff(
    ObjectId id,
  ) {
    RealmObjectBase.set(this, '_id', id);
  }

  Stuff._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  Stream<RealmObjectChanges<Stuff>> get changes =>
      RealmObjectBase.getChanges<Stuff>(this);

  @override
  Stuff freeze() => RealmObjectBase.freezeObject<Stuff>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Stuff._);
    return const SchemaObject(ObjectType.realmObject, Stuff, 'Stuff', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
    ]);
  }
}
