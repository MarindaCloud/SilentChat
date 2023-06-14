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

abstract class _$DBManager extends GeneratedDatabase {
  _$DBManager(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $RecordMessageTable recordMessage = $RecordMessageTable(this);
  late final RecordMessageDao recordMessageDao =
      RecordMessageDao(this as DBManager);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recordMessage];
}
