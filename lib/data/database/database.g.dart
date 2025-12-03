// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CollectivitiesTable extends Collectivities
    with TableInfo<$CollectivitiesTable, CollectivityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _collectivityIdMeta =
      const VerificationMeta('collectivityId');
  @override
  late final GeneratedColumn<String> collectivityId = GeneratedColumn<String>(
      'collectivityId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, collectivityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collectivity';
  @override
  VerificationContext validateIntegrity(Insertable<CollectivityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collectivityId')) {
      context.handle(
          _collectivityIdMeta,
          collectivityId.isAcceptableOrUnknown(
              data['collectivityId']!, _collectivityIdMeta));
    } else if (isInserting) {
      context.missing(_collectivityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectivityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectivityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      collectivityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectivityId'])!,
    );
  }

  @override
  $CollectivitiesTable createAlias(String alias) {
    return $CollectivitiesTable(attachedDatabase, alias);
  }
}

class CollectivityData extends DataClass
    implements Insertable<CollectivityData> {
  final int id;
  final String collectivityId;
  const CollectivityData({required this.id, required this.collectivityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collectivityId'] = Variable<String>(collectivityId);
    return map;
  }

  CollectivitiesCompanion toCompanion(bool nullToAbsent) {
    return CollectivitiesCompanion(
      id: Value(id),
      collectivityId: Value(collectivityId),
    );
  }

  factory CollectivityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectivityData(
      id: serializer.fromJson<int>(json['id']),
      collectivityId: serializer.fromJson<String>(json['collectivityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectivityId': serializer.toJson<String>(collectivityId),
    };
  }

  CollectivityData copyWith({int? id, String? collectivityId}) =>
      CollectivityData(
        id: id ?? this.id,
        collectivityId: collectivityId ?? this.collectivityId,
      );
  CollectivityData copyWithCompanion(CollectivitiesCompanion data) {
    return CollectivityData(
      id: data.id.present ? data.id.value : this.id,
      collectivityId: data.collectivityId.present
          ? data.collectivityId.value
          : this.collectivityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectivityData(')
          ..write('id: $id, ')
          ..write('collectivityId: $collectivityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectivityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectivityData &&
          other.id == this.id &&
          other.collectivityId == this.collectivityId);
}

class CollectivitiesCompanion extends UpdateCompanion<CollectivityData> {
  final Value<int> id;
  final Value<String> collectivityId;
  const CollectivitiesCompanion({
    this.id = const Value.absent(),
    this.collectivityId = const Value.absent(),
  });
  CollectivitiesCompanion.insert({
    this.id = const Value.absent(),
    required String collectivityId,
  }) : collectivityId = Value(collectivityId);
  static Insertable<CollectivityData> custom({
    Expression<int>? id,
    Expression<String>? collectivityId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectivityId != null) 'collectivityId': collectivityId,
    });
  }

  CollectivitiesCompanion copyWith(
      {Value<int>? id, Value<String>? collectivityId}) {
    return CollectivitiesCompanion(
      id: id ?? this.id,
      collectivityId: collectivityId ?? this.collectivityId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectivityId.present) {
      map['collectivityId'] = Variable<String>(collectivityId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectivitiesCompanion(')
          ..write('id: $id, ')
          ..write('collectivityId: $collectivityId')
          ..write(')'))
        .toString();
  }
}

class $GroupsTable extends Groups with TableInfo<$GroupsTable, GroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _collectivityIdMeta =
      const VerificationMeta('collectivityId');
  @override
  late final GeneratedColumn<String> collectivityId = GeneratedColumn<String>(
      'collectivity_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES collectivity(collectivityId) ON DELETE CASCADE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creatorIdMeta =
      const VerificationMeta('creatorId');
  @override
  late final GeneratedColumn<String> creatorId = GeneratedColumn<String>(
      'creator_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageIdMeta =
      const VerificationMeta('imageId');
  @override
  late final GeneratedColumn<String> imageId = GeneratedColumn<String>(
      'image_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(Status.created.name));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        collectivityId,
        name,
        creatorId,
        description,
        imageId,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group';
  @override
  VerificationContext validateIntegrity(Insertable<GroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collectivity_id')) {
      context.handle(
          _collectivityIdMeta,
          collectivityId.isAcceptableOrUnknown(
              data['collectivity_id']!, _collectivityIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('creator_id')) {
      context.handle(_creatorIdMeta,
          creatorId.isAcceptableOrUnknown(data['creator_id']!, _creatorIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      collectivityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectivity_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      creatorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator_id']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final String? collectivityId;
  final String? name;
  final String? creatorId;
  final String? description;
  final String? imageId;
  final String status;
  final DateTime createdAt;
  const GroupData(
      {required this.id,
      this.collectivityId,
      this.name,
      this.creatorId,
      this.description,
      this.imageId,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || collectivityId != null) {
      map['collectivity_id'] = Variable<String>(collectivityId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || creatorId != null) {
      map['creator_id'] = Variable<String>(creatorId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(
      id: Value(id),
      collectivityId: collectivityId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectivityId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      creatorId: creatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(creatorId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory GroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      collectivityId: serializer.fromJson<String?>(json['collectivityId']),
      name: serializer.fromJson<String?>(json['name']),
      creatorId: serializer.fromJson<String?>(json['creatorId']),
      description: serializer.fromJson<String?>(json['description']),
      imageId: serializer.fromJson<String?>(json['imageId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectivityId': serializer.toJson<String?>(collectivityId),
      'name': serializer.toJson<String?>(name),
      'creatorId': serializer.toJson<String?>(creatorId),
      'description': serializer.toJson<String?>(description),
      'imageId': serializer.toJson<String?>(imageId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GroupData copyWith(
          {int? id,
          Value<String?> collectivityId = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> creatorId = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> imageId = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      GroupData(
        id: id ?? this.id,
        collectivityId:
            collectivityId.present ? collectivityId.value : this.collectivityId,
        name: name.present ? name.value : this.name,
        creatorId: creatorId.present ? creatorId.value : this.creatorId,
        description: description.present ? description.value : this.description,
        imageId: imageId.present ? imageId.value : this.imageId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  GroupData copyWithCompanion(GroupsCompanion data) {
    return GroupData(
      id: data.id.present ? data.id.value : this.id,
      collectivityId: data.collectivityId.present
          ? data.collectivityId.value
          : this.collectivityId,
      name: data.name.present ? data.name.value : this.name,
      creatorId: data.creatorId.present ? data.creatorId.value : this.creatorId,
      description:
          data.description.present ? data.description.value : this.description,
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('collectivityId: $collectivityId, ')
          ..write('name: $name, ')
          ..write('creatorId: $creatorId, ')
          ..write('description: $description, ')
          ..write('imageId: $imageId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectivityId, name, creatorId,
      description, imageId, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.collectivityId == this.collectivityId &&
          other.name == this.name &&
          other.creatorId == this.creatorId &&
          other.description == this.description &&
          other.imageId == this.imageId &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class GroupsCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String?> collectivityId;
  final Value<String?> name;
  final Value<String?> creatorId;
  final Value<String?> description;
  final Value<String?> imageId;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.collectivityId = const Value.absent(),
    this.name = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.description = const Value.absent(),
    this.imageId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GroupsCompanion.insert({
    this.id = const Value.absent(),
    this.collectivityId = const Value.absent(),
    this.name = const Value.absent(),
    this.creatorId = const Value.absent(),
    this.description = const Value.absent(),
    this.imageId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? collectivityId,
    Expression<String>? name,
    Expression<String>? creatorId,
    Expression<String>? description,
    Expression<String>? imageId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectivityId != null) 'collectivity_id': collectivityId,
      if (name != null) 'name': name,
      if (creatorId != null) 'creator_id': creatorId,
      if (description != null) 'description': description,
      if (imageId != null) 'image_id': imageId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GroupsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? collectivityId,
      Value<String?>? name,
      Value<String?>? creatorId,
      Value<String?>? description,
      Value<String?>? imageId,
      Value<String>? status,
      Value<DateTime>? createdAt}) {
    return GroupsCompanion(
      id: id ?? this.id,
      collectivityId: collectivityId ?? this.collectivityId,
      name: name ?? this.name,
      creatorId: creatorId ?? this.creatorId,
      description: description ?? this.description,
      imageId: imageId ?? this.imageId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectivityId.present) {
      map['collectivity_id'] = Variable<String>(collectivityId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creatorId.present) {
      map['creator_id'] = Variable<String>(creatorId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('collectivityId: $collectivityId, ')
          ..write('name: $name, ')
          ..write('creatorId: $creatorId, ')
          ..write('description: $description, ')
          ..write('imageId: $imageId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DyadTable extends Dyad with TableInfo<$DyadTable, DyadData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DyadTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _collectivityIdMeta =
      const VerificationMeta('collectivityId');
  @override
  late final GeneratedColumn<String> collectivityId = GeneratedColumn<String>(
      'collectivity_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES collectivity(collectivityId) ON DELETE CASCADE');
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(Status.created.name));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, collectivityId, userId, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dyad';
  @override
  VerificationContext validateIntegrity(Insertable<DyadData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collectivity_id')) {
      context.handle(
          _collectivityIdMeta,
          collectivityId.isAcceptableOrUnknown(
              data['collectivity_id']!, _collectivityIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DyadData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DyadData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      collectivityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectivity_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DyadTable createAlias(String alias) {
    return $DyadTable(attachedDatabase, alias);
  }
}

class DyadData extends DataClass implements Insertable<DyadData> {
  final int id;
  final String? collectivityId;
  final String? userId;
  final String status;
  final DateTime createdAt;
  const DyadData(
      {required this.id,
      this.collectivityId,
      this.userId,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || collectivityId != null) {
      map['collectivity_id'] = Variable<String>(collectivityId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DyadCompanion toCompanion(bool nullToAbsent) {
    return DyadCompanion(
      id: Value(id),
      collectivityId: collectivityId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectivityId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory DyadData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DyadData(
      id: serializer.fromJson<int>(json['id']),
      collectivityId: serializer.fromJson<String?>(json['collectivityId']),
      userId: serializer.fromJson<String?>(json['userId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectivityId': serializer.toJson<String?>(collectivityId),
      'userId': serializer.toJson<String?>(userId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DyadData copyWith(
          {int? id,
          Value<String?> collectivityId = const Value.absent(),
          Value<String?> userId = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      DyadData(
        id: id ?? this.id,
        collectivityId:
            collectivityId.present ? collectivityId.value : this.collectivityId,
        userId: userId.present ? userId.value : this.userId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  DyadData copyWithCompanion(DyadCompanion data) {
    return DyadData(
      id: data.id.present ? data.id.value : this.id,
      collectivityId: data.collectivityId.present
          ? data.collectivityId.value
          : this.collectivityId,
      userId: data.userId.present ? data.userId.value : this.userId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DyadData(')
          ..write('id: $id, ')
          ..write('collectivityId: $collectivityId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, collectivityId, userId, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DyadData &&
          other.id == this.id &&
          other.collectivityId == this.collectivityId &&
          other.userId == this.userId &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class DyadCompanion extends UpdateCompanion<DyadData> {
  final Value<int> id;
  final Value<String?> collectivityId;
  final Value<String?> userId;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const DyadCompanion({
    this.id = const Value.absent(),
    this.collectivityId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DyadCompanion.insert({
    this.id = const Value.absent(),
    this.collectivityId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<DyadData> custom({
    Expression<int>? id,
    Expression<String>? collectivityId,
    Expression<String>? userId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectivityId != null) 'collectivity_id': collectivityId,
      if (userId != null) 'user_id': userId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DyadCompanion copyWith(
      {Value<int>? id,
      Value<String?>? collectivityId,
      Value<String?>? userId,
      Value<String>? status,
      Value<DateTime>? createdAt}) {
    return DyadCompanion(
      id: id ?? this.id,
      collectivityId: collectivityId ?? this.collectivityId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectivityId.present) {
      map['collectivity_id'] = Variable<String>(collectivityId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DyadCompanion(')
          ..write('id: $id, ')
          ..write('collectivityId: $collectivityId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ParticipantsTable extends Participants
    with TableInfo<$ParticipantsTable, ParticipantData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectivityIdMeta =
      const VerificationMeta('collectivityId');
  @override
  late final GeneratedColumn<String> collectivityId = GeneratedColumn<String>(
      'collectivity_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES collectivity(collectivityId) ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [id, userId, collectivityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'participants';
  @override
  VerificationContext validateIntegrity(Insertable<ParticipantData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('collectivity_id')) {
      context.handle(
          _collectivityIdMeta,
          collectivityId.isAcceptableOrUnknown(
              data['collectivity_id']!, _collectivityIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParticipantData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParticipantData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      collectivityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectivity_id']),
    );
  }

  @override
  $ParticipantsTable createAlias(String alias) {
    return $ParticipantsTable(attachedDatabase, alias);
  }
}

class ParticipantData extends DataClass implements Insertable<ParticipantData> {
  final int id;
  final String userId;
  final String? collectivityId;
  const ParticipantData(
      {required this.id, required this.userId, this.collectivityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || collectivityId != null) {
      map['collectivity_id'] = Variable<String>(collectivityId);
    }
    return map;
  }

  ParticipantsCompanion toCompanion(bool nullToAbsent) {
    return ParticipantsCompanion(
      id: Value(id),
      userId: Value(userId),
      collectivityId: collectivityId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectivityId),
    );
  }

  factory ParticipantData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParticipantData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      collectivityId: serializer.fromJson<String?>(json['collectivityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'collectivityId': serializer.toJson<String?>(collectivityId),
    };
  }

  ParticipantData copyWith(
          {int? id,
          String? userId,
          Value<String?> collectivityId = const Value.absent()}) =>
      ParticipantData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        collectivityId:
            collectivityId.present ? collectivityId.value : this.collectivityId,
      );
  ParticipantData copyWithCompanion(ParticipantsCompanion data) {
    return ParticipantData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      collectivityId: data.collectivityId.present
          ? data.collectivityId.value
          : this.collectivityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParticipantData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('collectivityId: $collectivityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, collectivityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParticipantData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.collectivityId == this.collectivityId);
}

class ParticipantsCompanion extends UpdateCompanion<ParticipantData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String?> collectivityId;
  const ParticipantsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.collectivityId = const Value.absent(),
  });
  ParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.collectivityId = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<ParticipantData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? collectivityId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (collectivityId != null) 'collectivity_id': collectivityId,
    });
  }

  ParticipantsCompanion copyWith(
      {Value<int>? id, Value<String>? userId, Value<String?>? collectivityId}) {
    return ParticipantsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      collectivityId: collectivityId ?? this.collectivityId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (collectivityId.present) {
      map['collectivity_id'] = Variable<String>(collectivityId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('collectivityId: $collectivityId')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, PersonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _personIdMeta =
      const VerificationMeta('personId');
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
      'person_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageIdMeta =
      const VerificationMeta('imageId');
  @override
  late final GeneratedColumn<String> imageId = GeneratedColumn<String>(
      'image_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(Status.created.name));
  @override
  List<GeneratedColumn> get $columns =>
      [id, personId, name, username, description, imageId, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<PersonData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      personId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class PersonData extends DataClass implements Insertable<PersonData> {
  final int id;
  final String personId;
  final String? name;
  final String? username;
  final String? description;
  final String? imageId;
  final String status;
  const PersonData(
      {required this.id,
      required this.personId,
      this.name,
      this.username,
      this.description,
      this.imageId,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['person_id'] = Variable<String>(personId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      personId: Value(personId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      status: Value(status),
    );
  }

  factory PersonData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonData(
      id: serializer.fromJson<int>(json['id']),
      personId: serializer.fromJson<String>(json['personId']),
      name: serializer.fromJson<String?>(json['name']),
      username: serializer.fromJson<String?>(json['username']),
      description: serializer.fromJson<String?>(json['description']),
      imageId: serializer.fromJson<String?>(json['imageId']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'personId': serializer.toJson<String>(personId),
      'name': serializer.toJson<String?>(name),
      'username': serializer.toJson<String?>(username),
      'description': serializer.toJson<String?>(description),
      'imageId': serializer.toJson<String?>(imageId),
      'status': serializer.toJson<String>(status),
    };
  }

  PersonData copyWith(
          {int? id,
          String? personId,
          Value<String?> name = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> imageId = const Value.absent(),
          String? status}) =>
      PersonData(
        id: id ?? this.id,
        personId: personId ?? this.personId,
        name: name.present ? name.value : this.name,
        username: username.present ? username.value : this.username,
        description: description.present ? description.value : this.description,
        imageId: imageId.present ? imageId.value : this.imageId,
        status: status ?? this.status,
      );
  PersonData copyWithCompanion(PersonsCompanion data) {
    return PersonData(
      id: data.id.present ? data.id.value : this.id,
      personId: data.personId.present ? data.personId.value : this.personId,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      description:
          data.description.present ? data.description.value : this.description,
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonData(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('description: $description, ')
          ..write('imageId: $imageId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, personId, name, username, description, imageId, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonData &&
          other.id == this.id &&
          other.personId == this.personId &&
          other.name == this.name &&
          other.username == this.username &&
          other.description == this.description &&
          other.imageId == this.imageId &&
          other.status == this.status);
}

class PersonsCompanion extends UpdateCompanion<PersonData> {
  final Value<int> id;
  final Value<String> personId;
  final Value<String?> name;
  final Value<String?> username;
  final Value<String?> description;
  final Value<String?> imageId;
  final Value<String> status;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.personId = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.description = const Value.absent(),
    this.imageId = const Value.absent(),
    this.status = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.id = const Value.absent(),
    required String personId,
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.description = const Value.absent(),
    this.imageId = const Value.absent(),
    this.status = const Value.absent(),
  }) : personId = Value(personId);
  static Insertable<PersonData> custom({
    Expression<int>? id,
    Expression<String>? personId,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? description,
    Expression<String>? imageId,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personId != null) 'person_id': personId,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (description != null) 'description': description,
      if (imageId != null) 'image_id': imageId,
      if (status != null) 'status': status,
    });
  }

  PersonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? personId,
      Value<String?>? name,
      Value<String?>? username,
      Value<String?>? description,
      Value<String?>? imageId,
      Value<String>? status}) {
    return PersonsCompanion(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      name: name ?? this.name,
      username: username ?? this.username,
      description: description ?? this.description,
      imageId: imageId ?? this.imageId,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('description: $description, ')
          ..write('imageId: $imageId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages
    with TableInfo<$MessagesTable, MessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
      'message_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectivityIdMeta =
      const VerificationMeta('collectivityId');
  @override
  late final GeneratedColumn<String> collectivityId = GeneratedColumn<String>(
      'collectivity_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES collectivity(collectivityId) ON DELETE CASCADE');
  static const VerificationMeta _dyadReceiverIdMeta =
      const VerificationMeta('dyadReceiverId');
  @override
  late final GeneratedColumn<String> dyadReceiverId = GeneratedColumn<String>(
      'dyad_receiver_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sendTimeMeta =
      const VerificationMeta('sendTime');
  @override
  late final GeneratedColumn<DateTime> sendTime = GeneratedColumn<DateTime>(
      'send_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(Status.created.name));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        messageId,
        message,
        userId,
        collectivityId,
        dyadReceiverId,
        sendTime,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<MessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('collectivity_id')) {
      context.handle(
          _collectivityIdMeta,
          collectivityId.isAcceptableOrUnknown(
              data['collectivity_id']!, _collectivityIdMeta));
    }
    if (data.containsKey('dyad_receiver_id')) {
      context.handle(
          _dyadReceiverIdMeta,
          dyadReceiverId.isAcceptableOrUnknown(
              data['dyad_receiver_id']!, _dyadReceiverIdMeta));
    }
    if (data.containsKey('send_time')) {
      context.handle(_sendTimeMeta,
          sendTime.isAcceptableOrUnknown(data['send_time']!, _sendTimeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      collectivityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collectivity_id']),
      dyadReceiverId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}dyad_receiver_id']),
      sendTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}send_time']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class MessageData extends DataClass implements Insertable<MessageData> {
  final int id;
  final String messageId;
  final String message;
  final String userId;
  final String? collectivityId;
  final String? dyadReceiverId;
  final DateTime? sendTime;
  final String status;
  final DateTime createdAt;
  const MessageData(
      {required this.id,
      required this.messageId,
      required this.message,
      required this.userId,
      this.collectivityId,
      this.dyadReceiverId,
      this.sendTime,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<String>(messageId);
    map['message'] = Variable<String>(message);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || collectivityId != null) {
      map['collectivity_id'] = Variable<String>(collectivityId);
    }
    if (!nullToAbsent || dyadReceiverId != null) {
      map['dyad_receiver_id'] = Variable<String>(dyadReceiverId);
    }
    if (!nullToAbsent || sendTime != null) {
      map['send_time'] = Variable<DateTime>(sendTime);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      messageId: Value(messageId),
      message: Value(message),
      userId: Value(userId),
      collectivityId: collectivityId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectivityId),
      dyadReceiverId: dyadReceiverId == null && nullToAbsent
          ? const Value.absent()
          : Value(dyadReceiverId),
      sendTime: sendTime == null && nullToAbsent
          ? const Value.absent()
          : Value(sendTime),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory MessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageData(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      message: serializer.fromJson<String>(json['message']),
      userId: serializer.fromJson<String>(json['userId']),
      collectivityId: serializer.fromJson<String?>(json['collectivityId']),
      dyadReceiverId: serializer.fromJson<String?>(json['dyadReceiverId']),
      sendTime: serializer.fromJson<DateTime?>(json['sendTime']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<String>(messageId),
      'message': serializer.toJson<String>(message),
      'userId': serializer.toJson<String>(userId),
      'collectivityId': serializer.toJson<String?>(collectivityId),
      'dyadReceiverId': serializer.toJson<String?>(dyadReceiverId),
      'sendTime': serializer.toJson<DateTime?>(sendTime),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MessageData copyWith(
          {int? id,
          String? messageId,
          String? message,
          String? userId,
          Value<String?> collectivityId = const Value.absent(),
          Value<String?> dyadReceiverId = const Value.absent(),
          Value<DateTime?> sendTime = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      MessageData(
        id: id ?? this.id,
        messageId: messageId ?? this.messageId,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        collectivityId:
            collectivityId.present ? collectivityId.value : this.collectivityId,
        dyadReceiverId:
            dyadReceiverId.present ? dyadReceiverId.value : this.dyadReceiverId,
        sendTime: sendTime.present ? sendTime.value : this.sendTime,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  MessageData copyWithCompanion(MessagesCompanion data) {
    return MessageData(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      message: data.message.present ? data.message.value : this.message,
      userId: data.userId.present ? data.userId.value : this.userId,
      collectivityId: data.collectivityId.present
          ? data.collectivityId.value
          : this.collectivityId,
      dyadReceiverId: data.dyadReceiverId.present
          ? data.dyadReceiverId.value
          : this.dyadReceiverId,
      sendTime: data.sendTime.present ? data.sendTime.value : this.sendTime,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageData(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('message: $message, ')
          ..write('userId: $userId, ')
          ..write('collectivityId: $collectivityId, ')
          ..write('dyadReceiverId: $dyadReceiverId, ')
          ..write('sendTime: $sendTime, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, message, userId,
      collectivityId, dyadReceiverId, sendTime, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageData &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.message == this.message &&
          other.userId == this.userId &&
          other.collectivityId == this.collectivityId &&
          other.dyadReceiverId == this.dyadReceiverId &&
          other.sendTime == this.sendTime &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<MessageData> {
  final Value<int> id;
  final Value<String> messageId;
  final Value<String> message;
  final Value<String> userId;
  final Value<String?> collectivityId;
  final Value<String?> dyadReceiverId;
  final Value<DateTime?> sendTime;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.message = const Value.absent(),
    this.userId = const Value.absent(),
    this.collectivityId = const Value.absent(),
    this.dyadReceiverId = const Value.absent(),
    this.sendTime = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required String messageId,
    required String message,
    required String userId,
    this.collectivityId = const Value.absent(),
    this.dyadReceiverId = const Value.absent(),
    this.sendTime = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : messageId = Value(messageId),
        message = Value(message),
        userId = Value(userId);
  static Insertable<MessageData> custom({
    Expression<int>? id,
    Expression<String>? messageId,
    Expression<String>? message,
    Expression<String>? userId,
    Expression<String>? collectivityId,
    Expression<String>? dyadReceiverId,
    Expression<DateTime>? sendTime,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (message != null) 'message': message,
      if (userId != null) 'user_id': userId,
      if (collectivityId != null) 'collectivity_id': collectivityId,
      if (dyadReceiverId != null) 'dyad_receiver_id': dyadReceiverId,
      if (sendTime != null) 'send_time': sendTime,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? messageId,
      Value<String>? message,
      Value<String>? userId,
      Value<String?>? collectivityId,
      Value<String?>? dyadReceiverId,
      Value<DateTime?>? sendTime,
      Value<String>? status,
      Value<DateTime>? createdAt}) {
    return MessagesCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      collectivityId: collectivityId ?? this.collectivityId,
      dyadReceiverId: dyadReceiverId ?? this.dyadReceiverId,
      sendTime: sendTime ?? this.sendTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (collectivityId.present) {
      map['collectivity_id'] = Variable<String>(collectivityId.value);
    }
    if (dyadReceiverId.present) {
      map['dyad_receiver_id'] = Variable<String>(dyadReceiverId.value);
    }
    if (sendTime.present) {
      map['send_time'] = Variable<DateTime>(sendTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('message: $message, ')
          ..write('userId: $userId, ')
          ..write('collectivityId: $collectivityId, ')
          ..write('dyadReceiverId: $dyadReceiverId, ')
          ..write('sendTime: $sendTime, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(Status.created.name));
  @override
  List<GeneratedColumn> get $columns => [id, name, username, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<ContactData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactData extends DataClass implements Insertable<ContactData> {
  final int id;
  final String name;
  final String username;
  final String status;
  const ContactData(
      {required this.id,
      required this.name,
      required this.username,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['username'] = Variable<String>(username);
    map['status'] = Variable<String>(status);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      name: Value(name),
      username: Value(username),
      status: Value(status),
    );
  }

  factory ContactData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      username: serializer.fromJson<String>(json['username']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'username': serializer.toJson<String>(username),
      'status': serializer.toJson<String>(status),
    };
  }

  ContactData copyWith(
          {int? id, String? name, String? username, String? status}) =>
      ContactData(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        status: status ?? this.status,
      );
  ContactData copyWithCompanion(ContactsCompanion data) {
    return ContactData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, username, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactData &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.status == this.status);
}

class ContactsCompanion extends UpdateCompanion<ContactData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> username;
  final Value<String> status;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.status = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String username,
    this.status = const Value.absent(),
  })  : name = Value(name),
        username = Value(username);
  static Insertable<ContactData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (status != null) 'status': status,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? username,
      Value<String>? status}) {
    return ContactsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CollectivitiesTable collectivities = $CollectivitiesTable(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $DyadTable dyad = $DyadTable(this);
  late final $ParticipantsTable participants = $ParticipantsTable(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [collectivities, groups, dyad, participants, persons, messages, contacts];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('collectivity',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('group', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('collectivity',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('dyad', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('collectivity',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('participants', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('collectivity',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('messages', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$CollectivitiesTableCreateCompanionBuilder = CollectivitiesCompanion
    Function({
  Value<int> id,
  required String collectivityId,
});
typedef $$CollectivitiesTableUpdateCompanionBuilder = CollectivitiesCompanion
    Function({
  Value<int> id,
  Value<String> collectivityId,
});

final class $$CollectivitiesTableReferences extends BaseReferences<
    _$AppDatabase, $CollectivitiesTable, CollectivityData> {
  $$CollectivitiesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GroupsTable, List<GroupData>> _groupsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.groups,
          aliasName: $_aliasNameGenerator(
              db.collectivities.collectivityId, db.groups.collectivityId));

  $$GroupsTableProcessedTableManager get groupsRefs {
    final manager = $$GroupsTableTableManager($_db, $_db.groups).filter((f) => f
        .collectivityId.collectivityId
        .sqlEquals($_itemColumn<String>('collectivityId')!));

    final cache = $_typedResult.readTableOrNull(_groupsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DyadTable, List<DyadData>> _dyadRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.dyad,
          aliasName: $_aliasNameGenerator(
              db.collectivities.collectivityId, db.dyad.collectivityId));

  $$DyadTableProcessedTableManager get dyadRefs {
    final manager = $$DyadTableTableManager($_db, $_db.dyad).filter((f) => f
        .collectivityId.collectivityId
        .sqlEquals($_itemColumn<String>('collectivityId')!));

    final cache = $_typedResult.readTableOrNull(_dyadRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ParticipantsTable, List<ParticipantData>>
      _participantsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.participants,
              aliasName: $_aliasNameGenerator(db.collectivities.collectivityId,
                  db.participants.collectivityId));

  $$ParticipantsTableProcessedTableManager get participantsRefs {
    final manager = $$ParticipantsTableTableManager($_db, $_db.participants)
        .filter((f) => f.collectivityId.collectivityId
            .sqlEquals($_itemColumn<String>('collectivityId')!));

    final cache = $_typedResult.readTableOrNull(_participantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MessagesTable, List<MessageData>>
      _messagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.messages,
          aliasName: $_aliasNameGenerator(
              db.collectivities.collectivityId, db.messages.collectivityId));

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager($_db, $_db.messages).filter(
        (f) => f.collectivityId.collectivityId
            .sqlEquals($_itemColumn<String>('collectivityId')!));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CollectivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CollectivitiesTable> {
  $$CollectivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get collectivityId => $composableBuilder(
      column: $table.collectivityId,
      builder: (column) => ColumnFilters(column));

  Expression<bool> groupsRefs(
      Expression<bool> Function($$GroupsTableFilterComposer f) f) {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableFilterComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> dyadRefs(
      Expression<bool> Function($$DyadTableFilterComposer f) f) {
    final $$DyadTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.dyad,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DyadTableFilterComposer(
              $db: $db,
              $table: $db.dyad,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> participantsRefs(
      Expression<bool> Function($$ParticipantsTableFilterComposer f) f) {
    final $$ParticipantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.participants,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParticipantsTableFilterComposer(
              $db: $db,
              $table: $db.participants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> messagesRefs(
      Expression<bool> Function($$MessagesTableFilterComposer f) f) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableFilterComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CollectivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectivitiesTable> {
  $$CollectivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get collectivityId => $composableBuilder(
      column: $table.collectivityId,
      builder: (column) => ColumnOrderings(column));
}

class $$CollectivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectivitiesTable> {
  $$CollectivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectivityId => $composableBuilder(
      column: $table.collectivityId, builder: (column) => column);

  Expression<T> groupsRefs<T extends Object>(
      Expression<T> Function($$GroupsTableAnnotationComposer a) f) {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> dyadRefs<T extends Object>(
      Expression<T> Function($$DyadTableAnnotationComposer a) f) {
    final $$DyadTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.dyad,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DyadTableAnnotationComposer(
              $db: $db,
              $table: $db.dyad,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> participantsRefs<T extends Object>(
      Expression<T> Function($$ParticipantsTableAnnotationComposer a) f) {
    final $$ParticipantsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.participants,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParticipantsTableAnnotationComposer(
              $db: $db,
              $table: $db.participants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> messagesRefs<T extends Object>(
      Expression<T> Function($$MessagesTableAnnotationComposer a) f) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CollectivitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CollectivitiesTable,
    CollectivityData,
    $$CollectivitiesTableFilterComposer,
    $$CollectivitiesTableOrderingComposer,
    $$CollectivitiesTableAnnotationComposer,
    $$CollectivitiesTableCreateCompanionBuilder,
    $$CollectivitiesTableUpdateCompanionBuilder,
    (CollectivityData, $$CollectivitiesTableReferences),
    CollectivityData,
    PrefetchHooks Function(
        {bool groupsRefs,
        bool dyadRefs,
        bool participantsRefs,
        bool messagesRefs})> {
  $$CollectivitiesTableTableManager(
      _$AppDatabase db, $CollectivitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> collectivityId = const Value.absent(),
          }) =>
              CollectivitiesCompanion(
            id: id,
            collectivityId: collectivityId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String collectivityId,
          }) =>
              CollectivitiesCompanion.insert(
            id: id,
            collectivityId: collectivityId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CollectivitiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {groupsRefs = false,
              dyadRefs = false,
              participantsRefs = false,
              messagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (groupsRefs) db.groups,
                if (dyadRefs) db.dyad,
                if (participantsRefs) db.participants,
                if (messagesRefs) db.messages
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (groupsRefs)
                    await $_getPrefetchedData<CollectivityData,
                            $CollectivitiesTable, GroupData>(
                        currentTable: table,
                        referencedTable: $$CollectivitiesTableReferences
                            ._groupsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CollectivitiesTableReferences(db, table, p0)
                                .groupsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.collectivityId == item.collectivityId),
                        typedResults: items),
                  if (dyadRefs)
                    await $_getPrefetchedData<CollectivityData,
                            $CollectivitiesTable, DyadData>(
                        currentTable: table,
                        referencedTable:
                            $$CollectivitiesTableReferences._dyadRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CollectivitiesTableReferences(db, table, p0)
                                .dyadRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.collectivityId == item.collectivityId),
                        typedResults: items),
                  if (participantsRefs)
                    await $_getPrefetchedData<CollectivityData,
                            $CollectivitiesTable, ParticipantData>(
                        currentTable: table,
                        referencedTable: $$CollectivitiesTableReferences
                            ._participantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CollectivitiesTableReferences(db, table, p0)
                                .participantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.collectivityId == item.collectivityId),
                        typedResults: items),
                  if (messagesRefs)
                    await $_getPrefetchedData<CollectivityData,
                            $CollectivitiesTable, MessageData>(
                        currentTable: table,
                        referencedTable: $$CollectivitiesTableReferences
                            ._messagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CollectivitiesTableReferences(db, table, p0)
                                .messagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.collectivityId == item.collectivityId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CollectivitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CollectivitiesTable,
    CollectivityData,
    $$CollectivitiesTableFilterComposer,
    $$CollectivitiesTableOrderingComposer,
    $$CollectivitiesTableAnnotationComposer,
    $$CollectivitiesTableCreateCompanionBuilder,
    $$CollectivitiesTableUpdateCompanionBuilder,
    (CollectivityData, $$CollectivitiesTableReferences),
    CollectivityData,
    PrefetchHooks Function(
        {bool groupsRefs,
        bool dyadRefs,
        bool participantsRefs,
        bool messagesRefs})>;
typedef $$GroupsTableCreateCompanionBuilder = GroupsCompanion Function({
  Value<int> id,
  Value<String?> collectivityId,
  Value<String?> name,
  Value<String?> creatorId,
  Value<String?> description,
  Value<String?> imageId,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$GroupsTableUpdateCompanionBuilder = GroupsCompanion Function({
  Value<int> id,
  Value<String?> collectivityId,
  Value<String?> name,
  Value<String?> creatorId,
  Value<String?> description,
  Value<String?> imageId,
  Value<String> status,
  Value<DateTime> createdAt,
});

final class $$GroupsTableReferences
    extends BaseReferences<_$AppDatabase, $GroupsTable, GroupData> {
  $$GroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectivitiesTable _collectivityIdTable(_$AppDatabase db) =>
      db.collectivities.createAlias($_aliasNameGenerator(
          db.groups.collectivityId, db.collectivities.collectivityId));

  $$CollectivitiesTableProcessedTableManager? get collectivityId {
    final $_column = $_itemColumn<String>('collectivity_id');
    if ($_column == null) return null;
    final manager = $$CollectivitiesTableTableManager($_db, $_db.collectivities)
        .filter((f) => f.collectivityId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectivityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GroupsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get creatorId => $composableBuilder(
      column: $table.creatorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageId => $composableBuilder(
      column: $table.imageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CollectivitiesTableFilterComposer get collectivityId {
    final $$CollectivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableFilterComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get creatorId => $composableBuilder(
      column: $table.creatorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageId => $composableBuilder(
      column: $table.imageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CollectivitiesTableOrderingComposer get collectivityId {
    final $$CollectivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get creatorId =>
      $composableBuilder(column: $table.creatorId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageId =>
      $composableBuilder(column: $table.imageId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CollectivitiesTableAnnotationComposer get collectivityId {
    final $$CollectivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GroupsTable,
    GroupData,
    $$GroupsTableFilterComposer,
    $$GroupsTableOrderingComposer,
    $$GroupsTableAnnotationComposer,
    $$GroupsTableCreateCompanionBuilder,
    $$GroupsTableUpdateCompanionBuilder,
    (GroupData, $$GroupsTableReferences),
    GroupData,
    PrefetchHooks Function({bool collectivityId})> {
  $$GroupsTableTableManager(_$AppDatabase db, $GroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> collectivityId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> creatorId = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GroupsCompanion(
            id: id,
            collectivityId: collectivityId,
            name: name,
            creatorId: creatorId,
            description: description,
            imageId: imageId,
            status: status,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> collectivityId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> creatorId = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GroupsCompanion.insert(
            id: id,
            collectivityId: collectivityId,
            name: name,
            creatorId: creatorId,
            description: description,
            imageId: imageId,
            status: status,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GroupsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({collectivityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (collectivityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.collectivityId,
                    referencedTable:
                        $$GroupsTableReferences._collectivityIdTable(db),
                    referencedColumn: $$GroupsTableReferences
                        ._collectivityIdTable(db)
                        .collectivityId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GroupsTable,
    GroupData,
    $$GroupsTableFilterComposer,
    $$GroupsTableOrderingComposer,
    $$GroupsTableAnnotationComposer,
    $$GroupsTableCreateCompanionBuilder,
    $$GroupsTableUpdateCompanionBuilder,
    (GroupData, $$GroupsTableReferences),
    GroupData,
    PrefetchHooks Function({bool collectivityId})>;
typedef $$DyadTableCreateCompanionBuilder = DyadCompanion Function({
  Value<int> id,
  Value<String?> collectivityId,
  Value<String?> userId,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$DyadTableUpdateCompanionBuilder = DyadCompanion Function({
  Value<int> id,
  Value<String?> collectivityId,
  Value<String?> userId,
  Value<String> status,
  Value<DateTime> createdAt,
});

final class $$DyadTableReferences
    extends BaseReferences<_$AppDatabase, $DyadTable, DyadData> {
  $$DyadTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectivitiesTable _collectivityIdTable(_$AppDatabase db) =>
      db.collectivities.createAlias($_aliasNameGenerator(
          db.dyad.collectivityId, db.collectivities.collectivityId));

  $$CollectivitiesTableProcessedTableManager? get collectivityId {
    final $_column = $_itemColumn<String>('collectivity_id');
    if ($_column == null) return null;
    final manager = $$CollectivitiesTableTableManager($_db, $_db.collectivities)
        .filter((f) => f.collectivityId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectivityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DyadTableFilterComposer extends Composer<_$AppDatabase, $DyadTable> {
  $$DyadTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CollectivitiesTableFilterComposer get collectivityId {
    final $$CollectivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableFilterComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DyadTableOrderingComposer extends Composer<_$AppDatabase, $DyadTable> {
  $$DyadTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CollectivitiesTableOrderingComposer get collectivityId {
    final $$CollectivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DyadTableAnnotationComposer
    extends Composer<_$AppDatabase, $DyadTable> {
  $$DyadTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CollectivitiesTableAnnotationComposer get collectivityId {
    final $$CollectivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DyadTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DyadTable,
    DyadData,
    $$DyadTableFilterComposer,
    $$DyadTableOrderingComposer,
    $$DyadTableAnnotationComposer,
    $$DyadTableCreateCompanionBuilder,
    $$DyadTableUpdateCompanionBuilder,
    (DyadData, $$DyadTableReferences),
    DyadData,
    PrefetchHooks Function({bool collectivityId})> {
  $$DyadTableTableManager(_$AppDatabase db, $DyadTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DyadTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DyadTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DyadTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> collectivityId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DyadCompanion(
            id: id,
            collectivityId: collectivityId,
            userId: userId,
            status: status,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> collectivityId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DyadCompanion.insert(
            id: id,
            collectivityId: collectivityId,
            userId: userId,
            status: status,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DyadTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({collectivityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (collectivityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.collectivityId,
                    referencedTable:
                        $$DyadTableReferences._collectivityIdTable(db),
                    referencedColumn: $$DyadTableReferences
                        ._collectivityIdTable(db)
                        .collectivityId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DyadTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DyadTable,
    DyadData,
    $$DyadTableFilterComposer,
    $$DyadTableOrderingComposer,
    $$DyadTableAnnotationComposer,
    $$DyadTableCreateCompanionBuilder,
    $$DyadTableUpdateCompanionBuilder,
    (DyadData, $$DyadTableReferences),
    DyadData,
    PrefetchHooks Function({bool collectivityId})>;
typedef $$ParticipantsTableCreateCompanionBuilder = ParticipantsCompanion
    Function({
  Value<int> id,
  required String userId,
  Value<String?> collectivityId,
});
typedef $$ParticipantsTableUpdateCompanionBuilder = ParticipantsCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<String?> collectivityId,
});

final class $$ParticipantsTableReferences
    extends BaseReferences<_$AppDatabase, $ParticipantsTable, ParticipantData> {
  $$ParticipantsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectivitiesTable _collectivityIdTable(_$AppDatabase db) =>
      db.collectivities.createAlias($_aliasNameGenerator(
          db.participants.collectivityId, db.collectivities.collectivityId));

  $$CollectivitiesTableProcessedTableManager? get collectivityId {
    final $_column = $_itemColumn<String>('collectivity_id');
    if ($_column == null) return null;
    final manager = $$CollectivitiesTableTableManager($_db, $_db.collectivities)
        .filter((f) => f.collectivityId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectivityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $ParticipantsTable> {
  $$ParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  $$CollectivitiesTableFilterComposer get collectivityId {
    final $$CollectivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableFilterComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ParticipantsTable> {
  $$ParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  $$CollectivitiesTableOrderingComposer get collectivityId {
    final $$CollectivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParticipantsTable> {
  $$ParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  $$CollectivitiesTableAnnotationComposer get collectivityId {
    final $$CollectivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParticipantsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ParticipantsTable,
    ParticipantData,
    $$ParticipantsTableFilterComposer,
    $$ParticipantsTableOrderingComposer,
    $$ParticipantsTableAnnotationComposer,
    $$ParticipantsTableCreateCompanionBuilder,
    $$ParticipantsTableUpdateCompanionBuilder,
    (ParticipantData, $$ParticipantsTableReferences),
    ParticipantData,
    PrefetchHooks Function({bool collectivityId})> {
  $$ParticipantsTableTableManager(_$AppDatabase db, $ParticipantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParticipantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParticipantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParticipantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> collectivityId = const Value.absent(),
          }) =>
              ParticipantsCompanion(
            id: id,
            userId: userId,
            collectivityId: collectivityId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            Value<String?> collectivityId = const Value.absent(),
          }) =>
              ParticipantsCompanion.insert(
            id: id,
            userId: userId,
            collectivityId: collectivityId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ParticipantsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({collectivityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (collectivityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.collectivityId,
                    referencedTable:
                        $$ParticipantsTableReferences._collectivityIdTable(db),
                    referencedColumn: $$ParticipantsTableReferences
                        ._collectivityIdTable(db)
                        .collectivityId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ParticipantsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ParticipantsTable,
    ParticipantData,
    $$ParticipantsTableFilterComposer,
    $$ParticipantsTableOrderingComposer,
    $$ParticipantsTableAnnotationComposer,
    $$ParticipantsTableCreateCompanionBuilder,
    $$ParticipantsTableUpdateCompanionBuilder,
    (ParticipantData, $$ParticipantsTableReferences),
    ParticipantData,
    PrefetchHooks Function({bool collectivityId})>;
typedef $$PersonsTableCreateCompanionBuilder = PersonsCompanion Function({
  Value<int> id,
  required String personId,
  Value<String?> name,
  Value<String?> username,
  Value<String?> description,
  Value<String?> imageId,
  Value<String> status,
});
typedef $$PersonsTableUpdateCompanionBuilder = PersonsCompanion Function({
  Value<int> id,
  Value<String> personId,
  Value<String?> name,
  Value<String?> username,
  Value<String?> description,
  Value<String?> imageId,
  Value<String> status,
});

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageId => $composableBuilder(
      column: $table.imageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageId => $composableBuilder(
      column: $table.imageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageId =>
      $composableBuilder(column: $table.imageId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$PersonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PersonsTable,
    PersonData,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (PersonData, BaseReferences<_$AppDatabase, $PersonsTable, PersonData>),
    PersonData,
    PrefetchHooks Function()> {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> personId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageId = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              PersonsCompanion(
            id: id,
            personId: personId,
            name: name,
            username: username,
            description: description,
            imageId: imageId,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String personId,
            Value<String?> name = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageId = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              PersonsCompanion.insert(
            id: id,
            personId: personId,
            name: name,
            username: username,
            description: description,
            imageId: imageId,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PersonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PersonsTable,
    PersonData,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (PersonData, BaseReferences<_$AppDatabase, $PersonsTable, PersonData>),
    PersonData,
    PrefetchHooks Function()>;
typedef $$MessagesTableCreateCompanionBuilder = MessagesCompanion Function({
  Value<int> id,
  required String messageId,
  required String message,
  required String userId,
  Value<String?> collectivityId,
  Value<String?> dyadReceiverId,
  Value<DateTime?> sendTime,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$MessagesTableUpdateCompanionBuilder = MessagesCompanion Function({
  Value<int> id,
  Value<String> messageId,
  Value<String> message,
  Value<String> userId,
  Value<String?> collectivityId,
  Value<String?> dyadReceiverId,
  Value<DateTime?> sendTime,
  Value<String> status,
  Value<DateTime> createdAt,
});

final class $$MessagesTableReferences
    extends BaseReferences<_$AppDatabase, $MessagesTable, MessageData> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectivitiesTable _collectivityIdTable(_$AppDatabase db) =>
      db.collectivities.createAlias($_aliasNameGenerator(
          db.messages.collectivityId, db.collectivities.collectivityId));

  $$CollectivitiesTableProcessedTableManager? get collectivityId {
    final $_column = $_itemColumn<String>('collectivity_id');
    if ($_column == null) return null;
    final manager = $$CollectivitiesTableTableManager($_db, $_db.collectivities)
        .filter((f) => f.collectivityId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectivityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageId => $composableBuilder(
      column: $table.messageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dyadReceiverId => $composableBuilder(
      column: $table.dyadReceiverId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sendTime => $composableBuilder(
      column: $table.sendTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CollectivitiesTableFilterComposer get collectivityId {
    final $$CollectivitiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableFilterComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageId => $composableBuilder(
      column: $table.messageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dyadReceiverId => $composableBuilder(
      column: $table.dyadReceiverId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sendTime => $composableBuilder(
      column: $table.sendTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CollectivitiesTableOrderingComposer get collectivityId {
    final $$CollectivitiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableOrderingComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get dyadReceiverId => $composableBuilder(
      column: $table.dyadReceiverId, builder: (column) => column);

  GeneratedColumn<DateTime> get sendTime =>
      $composableBuilder(column: $table.sendTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CollectivitiesTableAnnotationComposer get collectivityId {
    final $$CollectivitiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectivityId,
        referencedTable: $db.collectivities,
        getReferencedColumn: (t) => t.collectivityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectivitiesTableAnnotationComposer(
              $db: $db,
              $table: $db.collectivities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessagesTable,
    MessageData,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (MessageData, $$MessagesTableReferences),
    MessageData,
    PrefetchHooks Function({bool collectivityId})> {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> messageId = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> collectivityId = const Value.absent(),
            Value<String?> dyadReceiverId = const Value.absent(),
            Value<DateTime?> sendTime = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MessagesCompanion(
            id: id,
            messageId: messageId,
            message: message,
            userId: userId,
            collectivityId: collectivityId,
            dyadReceiverId: dyadReceiverId,
            sendTime: sendTime,
            status: status,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String messageId,
            required String message,
            required String userId,
            Value<String?> collectivityId = const Value.absent(),
            Value<String?> dyadReceiverId = const Value.absent(),
            Value<DateTime?> sendTime = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MessagesCompanion.insert(
            id: id,
            messageId: messageId,
            message: message,
            userId: userId,
            collectivityId: collectivityId,
            dyadReceiverId: dyadReceiverId,
            sendTime: sendTime,
            status: status,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MessagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({collectivityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (collectivityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.collectivityId,
                    referencedTable:
                        $$MessagesTableReferences._collectivityIdTable(db),
                    referencedColumn: $$MessagesTableReferences
                        ._collectivityIdTable(db)
                        .collectivityId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MessagesTable,
    MessageData,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (MessageData, $$MessagesTableReferences),
    MessageData,
    PrefetchHooks Function({bool collectivityId})>;
typedef $$ContactsTableCreateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  required String name,
  required String username,
  Value<String> status,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> username,
  Value<String> status,
});

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTable,
    ContactData,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (ContactData, BaseReferences<_$AppDatabase, $ContactsTable, ContactData>),
    ContactData,
    PrefetchHooks Function()> {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              ContactsCompanion(
            id: id,
            name: name,
            username: username,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String username,
            Value<String> status = const Value.absent(),
          }) =>
              ContactsCompanion.insert(
            id: id,
            name: name,
            username: username,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactsTable,
    ContactData,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (ContactData, BaseReferences<_$AppDatabase, $ContactsTable, ContactData>),
    ContactData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CollectivitiesTableTableManager get collectivities =>
      $$CollectivitiesTableTableManager(_db, _db.collectivities);
  $$GroupsTableTableManager get groups =>
      $$GroupsTableTableManager(_db, _db.groups);
  $$DyadTableTableManager get dyad => $$DyadTableTableManager(_db, _db.dyad);
  $$ParticipantsTableTableManager get participants =>
      $$ParticipantsTableTableManager(_db, _db.participants);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
}
