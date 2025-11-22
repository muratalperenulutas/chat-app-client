import 'package:drift/drift.dart';

@DataClassName('CollectivityData')
class Collectivities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectivityId => text().unique().named('collectivityId')();
  TextColumn get name => text().nullable()();
  TextColumn get creatorId => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get imageId => text().nullable()();
  TextColumn get collectivityType => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('CREATED'))();

  @override
  String get tableName => 'collectivity';
}

@DataClassName('ParticipantData')
class Participants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get collectivityId => text().nullable().customConstraint('REFERENCES collectivity(collectivityId) ON DELETE CASCADE')();
}

@DataClassName('PersonData')
class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get personId => text().unique()();
  TextColumn get name => text().nullable()();
  TextColumn get localName => text().nullable()();
  TextColumn get username => text().unique()();
  TextColumn get description => text().nullable()();
  TextColumn get imageId => text().nullable()();
  TextColumn get source => text().withDefault(const Constant('SERVER'))();
  IntColumn get isRegistered => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('CREATED'))();
}

@DataClassName('MessageData')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageId => text().unique()();
  TextColumn get message => text()();
  TextColumn get userId => text()();
  TextColumn get collectivityId => text().nullable().customConstraint('REFERENCES collectivity(collectivityId) ON DELETE CASCADE')();
  TextColumn get dyadReceiverId => text().nullable()();
  DateTimeColumn get sendTime => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('CREATED'))();
}

