// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_manager.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RecordMessageData extends DataClass
    implements Insertable<RecordMessageData> {
  final int? id;
  final int receiverId;
  final String message;
  RecordMessageData({this.id, required this.receiverId, required this.message});
  factory RecordMessageData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RecordMessageData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      receiverId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}receiver_id'])!,
      message: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}message'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['receiver_id'] = Variable<int>(receiverId);
    map['message'] = Variable<String>(message);
    return map;
  }

  RecordMessageCompanion toCompanion(bool nullToAbsent) {
    return RecordMessageCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      receiverId: Value(receiverId),
      message: Value(message),
    );
  }

  factory RecordMessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordMessageData(
      id: serializer.fromJson<int?>(json['id']),
      receiverId: serializer.fromJson<int>(json['receiverId']),
      message: serializer.fromJson<String>(json['message']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'receiverId': serializer.toJson<int>(receiverId),
      'message': serializer.toJson<String>(message),
    };
  }

  RecordMessageData copyWith({int? id, int? receiverId, String? message}) =>
      RecordMessageData(
        id: id ?? this.id,
        receiverId: receiverId ?? this.receiverId,
        message: message ?? this.message,
      );
  @override
  String toString() {
    return (StringBuffer('RecordMessageData(')
          ..write('id: $id, ')
          ..write('receiverId: $receiverId, ')
          ..write('message: $message')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, receiverId, message);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordMessageData &&
          other.id == this.id &&
          other.receiverId == this.receiverId &&
          other.message == this.message);
}

class RecordMessageCompanion extends UpdateCompanion<RecordMessageData> {
  final Value<int?> id;
  final Value<int> receiverId;
  final Value<String> message;
  const RecordMessageCompanion({
    this.id = const Value.absent(),
    this.receiverId = const Value.absent(),
    this.message = const Value.absent(),
  });
  RecordMessageCompanion.insert({
    this.id = const Value.absent(),
    required int receiverId,
    required String message,
  })  : receiverId = Value(receiverId),
        message = Value(message);
  static Insertable<RecordMessageData> custom({
    Expression<int?>? id,
    Expression<int>? receiverId,
    Expression<String>? message,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiverId != null) 'receiver_id': receiverId,
      if (message != null) 'message': message,
    });
  }

  RecordMessageCompanion copyWith(
      {Value<int?>? id, Value<int>? receiverId, Value<String>? message}) {
    return RecordMessageCompanion(
      id: id ?? this.id,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (receiverId.present) {
      map['receiver_id'] = Variable<int>(receiverId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordMessageCompanion(')
          ..write('id: $id, ')
          ..write('receiverId: $receiverId, ')
          ..write('message: $message')
          ..write(')'))
        .toString();
  }
}

class $RecordMessageTable extends RecordMessage
    with TableInfo<$RecordMessageTable, RecordMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordMessageTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _receiverIdMeta = const VerificationMeta('receiverId');
  @override
  late final GeneratedColumn<int?> receiverId = GeneratedColumn<int?>(
      'receiver_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedColumn<String?> message = GeneratedColumn<String?>(
      'message', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, receiverId, message];
  @override
  String get aliasedName => _alias ?? 'record_message';
  @override
  String get actualTableName => 'record_message';
  @override
  VerificationContext validateIntegrity(Insertable<RecordMessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receiver_id')) {
      context.handle(
          _receiverIdMeta,
          receiverId.isAcceptableOrUnknown(
              data['receiver_id']!, _receiverIdMeta));
    } else if (isInserting) {
      context.missing(_receiverIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return RecordMessageData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RecordMessageTable createAlias(String alias) {
    return $RecordMessageTable(attachedDatabase, alias);
  }
}

class GlobalImageCacheData extends DataClass
    implements Insertable<GlobalImageCacheData> {
  final int id;
  final int type;
  final String key;
  final String value;
  final Uint8List? blobValue;
  final int owner;
  GlobalImageCacheData(
      {required this.id,
      required this.type,
      required this.key,
      required this.value,
      this.blobValue,
      required this.owner});
  factory GlobalImageCacheData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return GlobalImageCacheData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      key: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}key'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
      blobValue: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}blob_value']),
      owner: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<int>(type);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || blobValue != null) {
      map['blob_value'] = Variable<Uint8List?>(blobValue);
    }
    map['owner'] = Variable<int>(owner);
    return map;
  }

  GlobalImageCacheCompanion toCompanion(bool nullToAbsent) {
    return GlobalImageCacheCompanion(
      id: Value(id),
      type: Value(type),
      key: Value(key),
      value: Value(value),
      blobValue: blobValue == null && nullToAbsent
          ? const Value.absent()
          : Value(blobValue),
      owner: Value(owner),
    );
  }

  factory GlobalImageCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlobalImageCacheData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<int>(json['type']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      blobValue: serializer.fromJson<Uint8List?>(json['blobValue']),
      owner: serializer.fromJson<int>(json['owner']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<int>(type),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'blobValue': serializer.toJson<Uint8List?>(blobValue),
      'owner': serializer.toJson<int>(owner),
    };
  }

  GlobalImageCacheData copyWith(
          {int? id,
          int? type,
          String? key,
          String? value,
          Uint8List? blobValue,
          int? owner}) =>
      GlobalImageCacheData(
        id: id ?? this.id,
        type: type ?? this.type,
        key: key ?? this.key,
        value: value ?? this.value,
        blobValue: blobValue ?? this.blobValue,
        owner: owner ?? this.owner,
      );
  @override
  String toString() {
    return (StringBuffer('GlobalImageCacheData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('blobValue: $blobValue, ')
          ..write('owner: $owner')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, key, value, blobValue, owner);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlobalImageCacheData &&
          other.id == this.id &&
          other.type == this.type &&
          other.key == this.key &&
          other.value == this.value &&
          other.blobValue == this.blobValue &&
          other.owner == this.owner);
}

class GlobalImageCacheCompanion extends UpdateCompanion<GlobalImageCacheData> {
  final Value<int> id;
  final Value<int> type;
  final Value<String> key;
  final Value<String> value;
  final Value<Uint8List?> blobValue;
  final Value<int> owner;
  const GlobalImageCacheCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.blobValue = const Value.absent(),
    this.owner = const Value.absent(),
  });
  GlobalImageCacheCompanion.insert({
    this.id = const Value.absent(),
    required int type,
    required String key,
    required String value,
    this.blobValue = const Value.absent(),
    required int owner,
  })  : type = Value(type),
        key = Value(key),
        value = Value(value),
        owner = Value(owner);
  static Insertable<GlobalImageCacheData> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<String>? key,
    Expression<String>? value,
    Expression<Uint8List?>? blobValue,
    Expression<int>? owner,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (blobValue != null) 'blob_value': blobValue,
      if (owner != null) 'owner': owner,
    });
  }

  GlobalImageCacheCompanion copyWith(
      {Value<int>? id,
      Value<int>? type,
      Value<String>? key,
      Value<String>? value,
      Value<Uint8List?>? blobValue,
      Value<int>? owner}) {
    return GlobalImageCacheCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      key: key ?? this.key,
      value: value ?? this.value,
      blobValue: blobValue ?? this.blobValue,
      owner: owner ?? this.owner,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (blobValue.present) {
      map['blob_value'] = Variable<Uint8List?>(blobValue.value);
    }
    if (owner.present) {
      map['owner'] = Variable<int>(owner.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlobalImageCacheCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('blobValue: $blobValue, ')
          ..write('owner: $owner')
          ..write(')'))
        .toString();
  }
}

class $GlobalImageCacheTable extends GlobalImageCache
    with TableInfo<$GlobalImageCacheTable, GlobalImageCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlobalImageCacheTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String?> key = GeneratedColumn<String?>(
      'key', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _blobValueMeta = const VerificationMeta('blobValue');
  @override
  late final GeneratedColumn<Uint8List?> blobValue =
      GeneratedColumn<Uint8List?>('blob_value', aliasedName, true,
          type: const BlobType(), requiredDuringInsert: false);
  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<int?> owner = GeneratedColumn<int?>(
      'owner', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, key, value, blobValue, owner];
  @override
  String get aliasedName => _alias ?? 'global_image_cache';
  @override
  String get actualTableName => 'global_image_cache';
  @override
  VerificationContext validateIntegrity(
      Insertable<GlobalImageCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('blob_value')) {
      context.handle(_blobValueMeta,
          blobValue.isAcceptableOrUnknown(data['blob_value']!, _blobValueMeta));
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlobalImageCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return GlobalImageCacheData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $GlobalImageCacheTable createAlias(String alias) {
    return $GlobalImageCacheTable(attachedDatabase, alias);
  }
}

abstract class _$DBManager extends GeneratedDatabase {
  _$DBManager(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $RecordMessageTable recordMessage = $RecordMessageTable(this);
  late final $GlobalImageCacheTable globalImageCache =
      $GlobalImageCacheTable(this);
  late final RecordMessageDao recordMessageDao =
      RecordMessageDao(this as DBManager);
  late final GlobalImageCacheDao globalImageCacheDao =
      GlobalImageCacheDao(this as DBManager);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [recordMessage, globalImageCache];
}
