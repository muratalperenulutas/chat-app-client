import 'package:drift/drift.dart';
import 'package:chat_app/constants/enums/status.dart';

@DataClassName('CollectivityData')
class Collectivities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectivityId => text().unique().named('collectivityId')();

  @override
  String get tableName => 'collectivity';
}

@DataClassName('GroupData')
class Groups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectivityId => text().nullable().customConstraint('REFERENCES collectivity(collectivityId) ON DELETE CASCADE')();
  TextColumn get name => text().nullable()();
  TextColumn get creatorId => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get imageId => text().nullable()();
  TextColumn get status => text().withDefault(Constant(Status.created.name))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'group';
}

@DataClassName('DyadData')
class Dyad extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectivityId => text().nullable().customConstraint('REFERENCES collectivity(collectivityId) ON DELETE CASCADE')();
  TextColumn get userId => text().nullable()();
  TextColumn get status => text().withDefault(Constant(Status.created.name))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'dyad';
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
  TextColumn get username => text().nullable().unique()();
  TextColumn get description => text().nullable()();
  TextColumn get imageId => text().nullable()();
  TextColumn get status => text().withDefault(Constant(Status.created.name))();
}

@DataClassName('ContactData')
class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get username => text().unique()();
  TextColumn get status => text().withDefault(Constant(Status.created.name))();
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
  TextColumn get status => text().withDefault(Constant(Status.created.name))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}


