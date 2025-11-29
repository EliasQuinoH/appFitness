// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteUserIdMeta = const VerificationMeta(
    'remoteUserId',
  );
  @override
  late final GeneratedColumn<String> remoteUserId = GeneratedColumn<String>(
    'remote_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 5,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _gameNameMeta = const VerificationMeta(
    'gameName',
  );
  @override
  late final GeneratedColumn<String> gameName = GeneratedColumn<String>(
    'game_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _experiencePointsMeta = const VerificationMeta(
    'experiencePoints',
  );
  @override
  late final GeneratedColumn<int> experiencePoints = GeneratedColumn<int>(
    'experience_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalWorkoutsMeta = const VerificationMeta(
    'totalWorkouts',
  );
  @override
  late final GeneratedColumn<int> totalWorkouts = GeneratedColumn<int>(
    'total_workouts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteUserId,
    email,
    gameName,
    level,
    experiencePoints,
    totalWorkouts,
    syncStatus,
    lastModified,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_user_id')) {
      context.handle(
        _remoteUserIdMeta,
        remoteUserId.isAcceptableOrUnknown(
          data['remote_user_id']!,
          _remoteUserIdMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('game_name')) {
      context.handle(
        _gameNameMeta,
        gameName.isAcceptableOrUnknown(data['game_name']!, _gameNameMeta),
      );
    } else if (isInserting) {
      context.missing(_gameNameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('experience_points')) {
      context.handle(
        _experiencePointsMeta,
        experiencePoints.isAcceptableOrUnknown(
          data['experience_points']!,
          _experiencePointsMeta,
        ),
      );
    }
    if (data.containsKey('total_workouts')) {
      context.handle(
        _totalWorkoutsMeta,
        totalWorkouts.isAcceptableOrUnknown(
          data['total_workouts']!,
          _totalWorkoutsMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {email},
  ];
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_user_id'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      gameName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_name'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      experiencePoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_points'],
      )!,
      totalWorkouts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_workouts'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final int id;
  final String? remoteUserId;
  final String email;
  final String gameName;
  final int level;
  final int experiencePoints;
  final int totalWorkouts;
  final int syncStatus;
  final DateTime lastModified;
  final bool isActive;
  const UsersTableData({
    required this.id,
    this.remoteUserId,
    required this.email,
    required this.gameName,
    required this.level,
    required this.experiencePoints,
    required this.totalWorkouts,
    required this.syncStatus,
    required this.lastModified,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteUserId != null) {
      map['remote_user_id'] = Variable<String>(remoteUserId);
    }
    map['email'] = Variable<String>(email);
    map['game_name'] = Variable<String>(gameName);
    map['level'] = Variable<int>(level);
    map['experience_points'] = Variable<int>(experiencePoints);
    map['total_workouts'] = Variable<int>(totalWorkouts);
    map['sync_status'] = Variable<int>(syncStatus);
    map['last_modified'] = Variable<DateTime>(lastModified);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      remoteUserId: remoteUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUserId),
      email: Value(email),
      gameName: Value(gameName),
      level: Value(level),
      experiencePoints: Value(experiencePoints),
      totalWorkouts: Value(totalWorkouts),
      syncStatus: Value(syncStatus),
      lastModified: Value(lastModified),
      isActive: Value(isActive),
    );
  }

  factory UsersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<int>(json['id']),
      remoteUserId: serializer.fromJson<String?>(json['remoteUserId']),
      email: serializer.fromJson<String>(json['email']),
      gameName: serializer.fromJson<String>(json['gameName']),
      level: serializer.fromJson<int>(json['level']),
      experiencePoints: serializer.fromJson<int>(json['experiencePoints']),
      totalWorkouts: serializer.fromJson<int>(json['totalWorkouts']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteUserId': serializer.toJson<String?>(remoteUserId),
      'email': serializer.toJson<String>(email),
      'gameName': serializer.toJson<String>(gameName),
      'level': serializer.toJson<int>(level),
      'experiencePoints': serializer.toJson<int>(experiencePoints),
      'totalWorkouts': serializer.toJson<int>(totalWorkouts),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'lastModified': serializer.toJson<DateTime>(lastModified),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  UsersTableData copyWith({
    int? id,
    Value<String?> remoteUserId = const Value.absent(),
    String? email,
    String? gameName,
    int? level,
    int? experiencePoints,
    int? totalWorkouts,
    int? syncStatus,
    DateTime? lastModified,
    bool? isActive,
  }) => UsersTableData(
    id: id ?? this.id,
    remoteUserId: remoteUserId.present ? remoteUserId.value : this.remoteUserId,
    email: email ?? this.email,
    gameName: gameName ?? this.gameName,
    level: level ?? this.level,
    experiencePoints: experiencePoints ?? this.experiencePoints,
    totalWorkouts: totalWorkouts ?? this.totalWorkouts,
    syncStatus: syncStatus ?? this.syncStatus,
    lastModified: lastModified ?? this.lastModified,
    isActive: isActive ?? this.isActive,
  );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      remoteUserId: data.remoteUserId.present
          ? data.remoteUserId.value
          : this.remoteUserId,
      email: data.email.present ? data.email.value : this.email,
      gameName: data.gameName.present ? data.gameName.value : this.gameName,
      level: data.level.present ? data.level.value : this.level,
      experiencePoints: data.experiencePoints.present
          ? data.experiencePoints.value
          : this.experiencePoints,
      totalWorkouts: data.totalWorkouts.present
          ? data.totalWorkouts.value
          : this.totalWorkouts,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('remoteUserId: $remoteUserId, ')
          ..write('email: $email, ')
          ..write('gameName: $gameName, ')
          ..write('level: $level, ')
          ..write('experiencePoints: $experiencePoints, ')
          ..write('totalWorkouts: $totalWorkouts, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastModified: $lastModified, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteUserId,
    email,
    gameName,
    level,
    experiencePoints,
    totalWorkouts,
    syncStatus,
    lastModified,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.remoteUserId == this.remoteUserId &&
          other.email == this.email &&
          other.gameName == this.gameName &&
          other.level == this.level &&
          other.experiencePoints == this.experiencePoints &&
          other.totalWorkouts == this.totalWorkouts &&
          other.syncStatus == this.syncStatus &&
          other.lastModified == this.lastModified &&
          other.isActive == this.isActive);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<int> id;
  final Value<String?> remoteUserId;
  final Value<String> email;
  final Value<String> gameName;
  final Value<int> level;
  final Value<int> experiencePoints;
  final Value<int> totalWorkouts;
  final Value<int> syncStatus;
  final Value<DateTime> lastModified;
  final Value<bool> isActive;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.remoteUserId = const Value.absent(),
    this.email = const Value.absent(),
    this.gameName = const Value.absent(),
    this.level = const Value.absent(),
    this.experiencePoints = const Value.absent(),
    this.totalWorkouts = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  UsersTableCompanion.insert({
    this.id = const Value.absent(),
    this.remoteUserId = const Value.absent(),
    required String email,
    required String gameName,
    required int level,
    this.experiencePoints = const Value.absent(),
    this.totalWorkouts = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : email = Value(email),
       gameName = Value(gameName),
       level = Value(level);
  static Insertable<UsersTableData> custom({
    Expression<int>? id,
    Expression<String>? remoteUserId,
    Expression<String>? email,
    Expression<String>? gameName,
    Expression<int>? level,
    Expression<int>? experiencePoints,
    Expression<int>? totalWorkouts,
    Expression<int>? syncStatus,
    Expression<DateTime>? lastModified,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteUserId != null) 'remote_user_id': remoteUserId,
      if (email != null) 'email': email,
      if (gameName != null) 'game_name': gameName,
      if (level != null) 'level': level,
      if (experiencePoints != null) 'experience_points': experiencePoints,
      if (totalWorkouts != null) 'total_workouts': totalWorkouts,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastModified != null) 'last_modified': lastModified,
      if (isActive != null) 'is_active': isActive,
    });
  }

  UsersTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? remoteUserId,
    Value<String>? email,
    Value<String>? gameName,
    Value<int>? level,
    Value<int>? experiencePoints,
    Value<int>? totalWorkouts,
    Value<int>? syncStatus,
    Value<DateTime>? lastModified,
    Value<bool>? isActive,
  }) {
    return UsersTableCompanion(
      id: id ?? this.id,
      remoteUserId: remoteUserId ?? this.remoteUserId,
      email: email ?? this.email,
      gameName: gameName ?? this.gameName,
      level: level ?? this.level,
      experiencePoints: experiencePoints ?? this.experiencePoints,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
      syncStatus: syncStatus ?? this.syncStatus,
      lastModified: lastModified ?? this.lastModified,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteUserId.present) {
      map['remote_user_id'] = Variable<String>(remoteUserId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (gameName.present) {
      map['game_name'] = Variable<String>(gameName.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (experiencePoints.present) {
      map['experience_points'] = Variable<int>(experiencePoints.value);
    }
    if (totalWorkouts.present) {
      map['total_workouts'] = Variable<int>(totalWorkouts.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('remoteUserId: $remoteUserId, ')
          ..write('email: $email, ')
          ..write('gameName: $gameName, ')
          ..write('level: $level, ')
          ..write('experiencePoints: $experiencePoints, ')
          ..write('totalWorkouts: $totalWorkouts, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastModified: $lastModified, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTableTable extends UserProfileTable
    with TableInfo<$UserProfileTableTable, UserProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issuesMeta = const VerificationMeta('issues');
  @override
  late final GeneratedColumn<String> issues = GeneratedColumn<String>(
    'issues',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _painsMeta = const VerificationMeta('pains');
  @override
  late final GeneratedColumn<String> pains = GeneratedColumn<String>(
    'pains',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentsMeta = const VerificationMeta(
    'comments',
  );
  @override
  late final GeneratedColumn<String> comments = GeneratedColumn<String>(
    'comments',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    weight,
    height,
    age,
    issues,
    pains,
    comments,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('issues')) {
      context.handle(
        _issuesMeta,
        issues.isAcceptableOrUnknown(data['issues']!, _issuesMeta),
      );
    }
    if (data.containsKey('pains')) {
      context.handle(
        _painsMeta,
        pains.isAcceptableOrUnknown(data['pains']!, _painsMeta),
      );
    }
    if (data.containsKey('comments')) {
      context.handle(
        _commentsMeta,
        comments.isAcceptableOrUnknown(data['comments']!, _commentsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      ),
      issues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issues'],
      ),
      pains: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pains'],
      ),
      comments: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comments'],
      ),
    );
  }

  @override
  $UserProfileTableTable createAlias(String alias) {
    return $UserProfileTableTable(attachedDatabase, alias);
  }
}

class UserProfileTableData extends DataClass
    implements Insertable<UserProfileTableData> {
  final int id;
  final int userId;
  final double weight;
  final double height;
  final int? age;
  final String? issues;
  final String? pains;
  final String? comments;
  const UserProfileTableData({
    required this.id,
    required this.userId,
    required this.weight,
    required this.height,
    this.age,
    this.issues,
    this.pains,
    this.comments,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['weight'] = Variable<double>(weight);
    map['height'] = Variable<double>(height);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || issues != null) {
      map['issues'] = Variable<String>(issues);
    }
    if (!nullToAbsent || pains != null) {
      map['pains'] = Variable<String>(pains);
    }
    if (!nullToAbsent || comments != null) {
      map['comments'] = Variable<String>(comments);
    }
    return map;
  }

  UserProfileTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfileTableCompanion(
      id: Value(id),
      userId: Value(userId),
      weight: Value(weight),
      height: Value(height),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      issues: issues == null && nullToAbsent
          ? const Value.absent()
          : Value(issues),
      pains: pains == null && nullToAbsent
          ? const Value.absent()
          : Value(pains),
      comments: comments == null && nullToAbsent
          ? const Value.absent()
          : Value(comments),
    );
  }

  factory UserProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      weight: serializer.fromJson<double>(json['weight']),
      height: serializer.fromJson<double>(json['height']),
      age: serializer.fromJson<int?>(json['age']),
      issues: serializer.fromJson<String?>(json['issues']),
      pains: serializer.fromJson<String?>(json['pains']),
      comments: serializer.fromJson<String?>(json['comments']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'weight': serializer.toJson<double>(weight),
      'height': serializer.toJson<double>(height),
      'age': serializer.toJson<int?>(age),
      'issues': serializer.toJson<String?>(issues),
      'pains': serializer.toJson<String?>(pains),
      'comments': serializer.toJson<String?>(comments),
    };
  }

  UserProfileTableData copyWith({
    int? id,
    int? userId,
    double? weight,
    double? height,
    Value<int?> age = const Value.absent(),
    Value<String?> issues = const Value.absent(),
    Value<String?> pains = const Value.absent(),
    Value<String?> comments = const Value.absent(),
  }) => UserProfileTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    weight: weight ?? this.weight,
    height: height ?? this.height,
    age: age.present ? age.value : this.age,
    issues: issues.present ? issues.value : this.issues,
    pains: pains.present ? pains.value : this.pains,
    comments: comments.present ? comments.value : this.comments,
  );
  UserProfileTableData copyWithCompanion(UserProfileTableCompanion data) {
    return UserProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      age: data.age.present ? data.age.value : this.age,
      issues: data.issues.present ? data.issues.value : this.issues,
      pains: data.pains.present ? data.pains.value : this.pains,
      comments: data.comments.present ? data.comments.value : this.comments,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('issues: $issues, ')
          ..write('pains: $pains, ')
          ..write('comments: $comments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, weight, height, age, issues, pains, comments);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.age == this.age &&
          other.issues == this.issues &&
          other.pains == this.pains &&
          other.comments == this.comments);
}

class UserProfileTableCompanion extends UpdateCompanion<UserProfileTableData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<double> weight;
  final Value<double> height;
  final Value<int?> age;
  final Value<String?> issues;
  final Value<String?> pains;
  final Value<String?> comments;
  const UserProfileTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.age = const Value.absent(),
    this.issues = const Value.absent(),
    this.pains = const Value.absent(),
    this.comments = const Value.absent(),
  });
  UserProfileTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required double weight,
    required double height,
    this.age = const Value.absent(),
    this.issues = const Value.absent(),
    this.pains = const Value.absent(),
    this.comments = const Value.absent(),
  }) : userId = Value(userId),
       weight = Value(weight),
       height = Value(height);
  static Insertable<UserProfileTableData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<int>? age,
    Expression<String>? issues,
    Expression<String>? pains,
    Expression<String>? comments,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (age != null) 'age': age,
      if (issues != null) 'issues': issues,
      if (pains != null) 'pains': pains,
      if (comments != null) 'comments': comments,
    });
  }

  UserProfileTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<double>? weight,
    Value<double>? height,
    Value<int?>? age,
    Value<String?>? issues,
    Value<String?>? pains,
    Value<String?>? comments,
  }) {
    return UserProfileTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      issues: issues ?? this.issues,
      pains: pains ?? this.pains,
      comments: comments ?? this.comments,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (issues.present) {
      map['issues'] = Variable<String>(issues.value);
    }
    if (pains.present) {
      map['pains'] = Variable<String>(pains.value);
    }
    if (comments.present) {
      map['comments'] = Variable<String>(comments.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('issues: $issues, ')
          ..write('pains: $pains, ')
          ..write('comments: $comments')
          ..write(')'))
        .toString();
  }
}

class $ExerciseTableTable extends ExerciseTable
    with TableInfo<$ExerciseTableTable, ExerciseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
    );
  }

  @override
  $ExerciseTableTable createAlias(String alias) {
    return $ExerciseTableTable(attachedDatabase, alias);
  }
}

class ExerciseTableData extends DataClass
    implements Insertable<ExerciseTableData> {
  final int id;
  final String name;
  final String? description;
  final String? type;
  const ExerciseTableData({
    required this.id,
    required this.name,
    this.description,
    this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  ExerciseTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory ExerciseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String?>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String?>(type),
    };
  }

  ExerciseTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> type = const Value.absent(),
  }) => ExerciseTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    type: type.present ? type.value : this.type,
  );
  ExerciseTableData copyWithCompanion(ExerciseTableCompanion data) {
    return ExerciseTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type);
}

class ExerciseTableCompanion extends UpdateCompanion<ExerciseTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> type;
  const ExerciseTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
  });
  ExerciseTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.type = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ExerciseTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
    });
  }

  ExerciseTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? type,
  }) {
    return ExerciseTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $RoutineTableTable extends RoutineTable
    with TableInfo<$RoutineTableTable, RoutineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $RoutineTableTable createAlias(String alias) {
    return $RoutineTableTable(attachedDatabase, alias);
  }
}

class RoutineTableData extends DataClass
    implements Insertable<RoutineTableData> {
  final int id;
  final String name;
  final String? description;
  const RoutineTableData({
    required this.id,
    required this.name,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  RoutineTableCompanion toCompanion(bool nullToAbsent) {
    return RoutineTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory RoutineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  RoutineTableData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => RoutineTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  RoutineTableData copyWithCompanion(RoutineTableCompanion data) {
    return RoutineTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class RoutineTableCompanion extends UpdateCompanion<RoutineTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const RoutineTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  RoutineTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<RoutineTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  RoutineTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
  }) {
    return RoutineTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $RoutineExerciseTableTable extends RoutineExerciseTable
    with TableInfo<$RoutineExerciseTableTable, RoutineExerciseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineExerciseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    exerciseId,
    reps,
    duration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_exercise_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineExerciseTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineExerciseTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineExerciseTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
    );
  }

  @override
  $RoutineExerciseTableTable createAlias(String alias) {
    return $RoutineExerciseTableTable(attachedDatabase, alias);
  }
}

class RoutineExerciseTableData extends DataClass
    implements Insertable<RoutineExerciseTableData> {
  final int id;
  final int routineId;
  final int exerciseId;
  final int? reps;
  final int? duration;
  const RoutineExerciseTableData({
    required this.id,
    required this.routineId,
    required this.exerciseId,
    this.reps,
    this.duration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_id'] = Variable<int>(routineId);
    map['exercise_id'] = Variable<int>(exerciseId);
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    return map;
  }

  RoutineExerciseTableCompanion toCompanion(bool nullToAbsent) {
    return RoutineExerciseTableCompanion(
      id: Value(id),
      routineId: Value(routineId),
      exerciseId: Value(exerciseId),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
    );
  }

  factory RoutineExerciseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineExerciseTableData(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int>(json['routineId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      reps: serializer.fromJson<int?>(json['reps']),
      duration: serializer.fromJson<int?>(json['duration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineId': serializer.toJson<int>(routineId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'reps': serializer.toJson<int?>(reps),
      'duration': serializer.toJson<int?>(duration),
    };
  }

  RoutineExerciseTableData copyWith({
    int? id,
    int? routineId,
    int? exerciseId,
    Value<int?> reps = const Value.absent(),
    Value<int?> duration = const Value.absent(),
  }) => RoutineExerciseTableData(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    exerciseId: exerciseId ?? this.exerciseId,
    reps: reps.present ? reps.value : this.reps,
    duration: duration.present ? duration.value : this.duration,
  );
  RoutineExerciseTableData copyWithCompanion(
    RoutineExerciseTableCompanion data,
  ) {
    return RoutineExerciseTableData(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      reps: data.reps.present ? data.reps.value : this.reps,
      duration: data.duration.present ? data.duration.value : this.duration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExerciseTableData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, exerciseId, reps, duration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineExerciseTableData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.exerciseId == this.exerciseId &&
          other.reps == this.reps &&
          other.duration == this.duration);
}

class RoutineExerciseTableCompanion
    extends UpdateCompanion<RoutineExerciseTableData> {
  final Value<int> id;
  final Value<int> routineId;
  final Value<int> exerciseId;
  final Value<int?> reps;
  final Value<int?> duration;
  const RoutineExerciseTableCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
  });
  RoutineExerciseTableCompanion.insert({
    this.id = const Value.absent(),
    required int routineId,
    required int exerciseId,
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
  }) : routineId = Value(routineId),
       exerciseId = Value(exerciseId);
  static Insertable<RoutineExerciseTableData> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<int>? exerciseId,
    Expression<int>? reps,
    Expression<int>? duration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (reps != null) 'reps': reps,
      if (duration != null) 'duration': duration,
    });
  }

  RoutineExerciseTableCompanion copyWith({
    Value<int>? id,
    Value<int>? routineId,
    Value<int>? exerciseId,
    Value<int?>? reps,
    Value<int?>? duration,
  }) {
    return RoutineExerciseTableCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      exerciseId: exerciseId ?? this.exerciseId,
      reps: reps ?? this.reps,
      duration: duration ?? this.duration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExerciseTableCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }
}

class $UserRoutineTableTable extends UserRoutineTable
    with TableInfo<$UserRoutineTableTable, UserRoutineTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRoutineTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, title, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_routine_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRoutineTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRoutineTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRoutineTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserRoutineTableTable createAlias(String alias) {
    return $UserRoutineTableTable(attachedDatabase, alias);
  }
}

class UserRoutineTableData extends DataClass
    implements Insertable<UserRoutineTableData> {
  final int id;
  final int userId;
  final String title;
  final String? notes;
  final DateTime createdAt;
  const UserRoutineTableData({
    required this.id,
    required this.userId,
    required this.title,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserRoutineTableCompanion toCompanion(bool nullToAbsent) {
    return UserRoutineTableCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory UserRoutineTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRoutineTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserRoutineTableData copyWith({
    int? id,
    int? userId,
    String? title,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => UserRoutineTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  UserRoutineTableData copyWithCompanion(UserRoutineTableCompanion data) {
    return UserRoutineTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRoutineTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRoutineTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class UserRoutineTableCompanion extends UpdateCompanion<UserRoutineTableData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> title;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const UserRoutineTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserRoutineTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String title,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : userId = Value(userId),
       title = Value(title);
  static Insertable<UserRoutineTableData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserRoutineTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? title,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return UserRoutineTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRoutineTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserRoutineExerciseTableTable extends UserRoutineExerciseTable
    with
        TableInfo<
          $UserRoutineExerciseTableTable,
          UserRoutineExerciseTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRoutineExerciseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userRoutineIdMeta = const VerificationMeta(
    'userRoutineId',
  );
  @override
  late final GeneratedColumn<int> userRoutineId = GeneratedColumn<int>(
    'user_routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<double> intensity = GeneratedColumn<double>(
    'intensity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userRoutineId,
    exerciseId,
    reps,
    duration,
    intensity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_routine_exercise_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRoutineExerciseTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_routine_id')) {
      context.handle(
        _userRoutineIdMeta,
        userRoutineId.isAcceptableOrUnknown(
          data['user_routine_id']!,
          _userRoutineIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userRoutineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRoutineExerciseTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRoutineExerciseTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userRoutineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_routine_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}intensity'],
      ),
    );
  }

  @override
  $UserRoutineExerciseTableTable createAlias(String alias) {
    return $UserRoutineExerciseTableTable(attachedDatabase, alias);
  }
}

class UserRoutineExerciseTableData extends DataClass
    implements Insertable<UserRoutineExerciseTableData> {
  final int id;
  final int userRoutineId;
  final int exerciseId;
  final int? reps;
  final int? duration;
  final double? intensity;
  const UserRoutineExerciseTableData({
    required this.id,
    required this.userRoutineId,
    required this.exerciseId,
    this.reps,
    this.duration,
    this.intensity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_routine_id'] = Variable<int>(userRoutineId);
    map['exercise_id'] = Variable<int>(exerciseId);
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || intensity != null) {
      map['intensity'] = Variable<double>(intensity);
    }
    return map;
  }

  UserRoutineExerciseTableCompanion toCompanion(bool nullToAbsent) {
    return UserRoutineExerciseTableCompanion(
      id: Value(id),
      userRoutineId: Value(userRoutineId),
      exerciseId: Value(exerciseId),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      intensity: intensity == null && nullToAbsent
          ? const Value.absent()
          : Value(intensity),
    );
  }

  factory UserRoutineExerciseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRoutineExerciseTableData(
      id: serializer.fromJson<int>(json['id']),
      userRoutineId: serializer.fromJson<int>(json['userRoutineId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      reps: serializer.fromJson<int?>(json['reps']),
      duration: serializer.fromJson<int?>(json['duration']),
      intensity: serializer.fromJson<double?>(json['intensity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userRoutineId': serializer.toJson<int>(userRoutineId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'reps': serializer.toJson<int?>(reps),
      'duration': serializer.toJson<int?>(duration),
      'intensity': serializer.toJson<double?>(intensity),
    };
  }

  UserRoutineExerciseTableData copyWith({
    int? id,
    int? userRoutineId,
    int? exerciseId,
    Value<int?> reps = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<double?> intensity = const Value.absent(),
  }) => UserRoutineExerciseTableData(
    id: id ?? this.id,
    userRoutineId: userRoutineId ?? this.userRoutineId,
    exerciseId: exerciseId ?? this.exerciseId,
    reps: reps.present ? reps.value : this.reps,
    duration: duration.present ? duration.value : this.duration,
    intensity: intensity.present ? intensity.value : this.intensity,
  );
  UserRoutineExerciseTableData copyWithCompanion(
    UserRoutineExerciseTableCompanion data,
  ) {
    return UserRoutineExerciseTableData(
      id: data.id.present ? data.id.value : this.id,
      userRoutineId: data.userRoutineId.present
          ? data.userRoutineId.value
          : this.userRoutineId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      reps: data.reps.present ? data.reps.value : this.reps,
      duration: data.duration.present ? data.duration.value : this.duration,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRoutineExerciseTableData(')
          ..write('id: $id, ')
          ..write('userRoutineId: $userRoutineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('intensity: $intensity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userRoutineId, exerciseId, reps, duration, intensity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRoutineExerciseTableData &&
          other.id == this.id &&
          other.userRoutineId == this.userRoutineId &&
          other.exerciseId == this.exerciseId &&
          other.reps == this.reps &&
          other.duration == this.duration &&
          other.intensity == this.intensity);
}

class UserRoutineExerciseTableCompanion
    extends UpdateCompanion<UserRoutineExerciseTableData> {
  final Value<int> id;
  final Value<int> userRoutineId;
  final Value<int> exerciseId;
  final Value<int?> reps;
  final Value<int?> duration;
  final Value<double?> intensity;
  const UserRoutineExerciseTableCompanion({
    this.id = const Value.absent(),
    this.userRoutineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    this.intensity = const Value.absent(),
  });
  UserRoutineExerciseTableCompanion.insert({
    this.id = const Value.absent(),
    required int userRoutineId,
    required int exerciseId,
    this.reps = const Value.absent(),
    this.duration = const Value.absent(),
    this.intensity = const Value.absent(),
  }) : userRoutineId = Value(userRoutineId),
       exerciseId = Value(exerciseId);
  static Insertable<UserRoutineExerciseTableData> custom({
    Expression<int>? id,
    Expression<int>? userRoutineId,
    Expression<int>? exerciseId,
    Expression<int>? reps,
    Expression<int>? duration,
    Expression<double>? intensity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userRoutineId != null) 'user_routine_id': userRoutineId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (reps != null) 'reps': reps,
      if (duration != null) 'duration': duration,
      if (intensity != null) 'intensity': intensity,
    });
  }

  UserRoutineExerciseTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userRoutineId,
    Value<int>? exerciseId,
    Value<int?>? reps,
    Value<int?>? duration,
    Value<double?>? intensity,
  }) {
    return UserRoutineExerciseTableCompanion(
      id: id ?? this.id,
      userRoutineId: userRoutineId ?? this.userRoutineId,
      exerciseId: exerciseId ?? this.exerciseId,
      reps: reps ?? this.reps,
      duration: duration ?? this.duration,
      intensity: intensity ?? this.intensity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userRoutineId.present) {
      map['user_routine_id'] = Variable<int>(userRoutineId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<double>(intensity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRoutineExerciseTableCompanion(')
          ..write('id: $id, ')
          ..write('userRoutineId: $userRoutineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('reps: $reps, ')
          ..write('duration: $duration, ')
          ..write('intensity: $intensity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $UserProfileTableTable userProfileTable = $UserProfileTableTable(
    this,
  );
  late final $ExerciseTableTable exerciseTable = $ExerciseTableTable(this);
  late final $RoutineTableTable routineTable = $RoutineTableTable(this);
  late final $RoutineExerciseTableTable routineExerciseTable =
      $RoutineExerciseTableTable(this);
  late final $UserRoutineTableTable userRoutineTable = $UserRoutineTableTable(
    this,
  );
  late final $UserRoutineExerciseTableTable userRoutineExerciseTable =
      $UserRoutineExerciseTableTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final UserProfileDao userProfileDao = UserProfileDao(
    this as AppDatabase,
  );
  late final ExerciseDao exerciseDao = ExerciseDao(this as AppDatabase);
  late final RoutineDao routineDao = RoutineDao(this as AppDatabase);
  late final RoutineExerciseDao routineExerciseDao = RoutineExerciseDao(
    this as AppDatabase,
  );
  late final UserRoutineDao userRoutineDao = UserRoutineDao(
    this as AppDatabase,
  );
  late final UserRoutineExerciseDao userRoutineExerciseDao =
      UserRoutineExerciseDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usersTable,
    userProfileTable,
    exerciseTable,
    routineTable,
    routineExerciseTable,
    userRoutineTable,
    userRoutineExerciseTable,
  ];
}

typedef $$UsersTableTableCreateCompanionBuilder =
    UsersTableCompanion Function({
      Value<int> id,
      Value<String?> remoteUserId,
      required String email,
      required String gameName,
      required int level,
      Value<int> experiencePoints,
      Value<int> totalWorkouts,
      Value<int> syncStatus,
      Value<DateTime> lastModified,
      Value<bool> isActive,
    });
typedef $$UsersTableTableUpdateCompanionBuilder =
    UsersTableCompanion Function({
      Value<int> id,
      Value<String?> remoteUserId,
      Value<String> email,
      Value<String> gameName,
      Value<int> level,
      Value<int> experiencePoints,
      Value<int> totalWorkouts,
      Value<int> syncStatus,
      Value<DateTime> lastModified,
      Value<bool> isActive,
    });

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUserId => $composableBuilder(
    column: $table.remoteUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameName => $composableBuilder(
    column: $table.gameName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experiencePoints => $composableBuilder(
    column: $table.experiencePoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalWorkouts => $composableBuilder(
    column: $table.totalWorkouts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUserId => $composableBuilder(
    column: $table.remoteUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameName => $composableBuilder(
    column: $table.gameName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experiencePoints => $composableBuilder(
    column: $table.experiencePoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalWorkouts => $composableBuilder(
    column: $table.totalWorkouts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteUserId => $composableBuilder(
    column: $table.remoteUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get gameName =>
      $composableBuilder(column: $table.gameName, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get experiencePoints => $composableBuilder(
    column: $table.experiencePoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalWorkouts => $composableBuilder(
    column: $table.totalWorkouts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$UsersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTableTable,
          UsersTableData,
          $$UsersTableTableFilterComposer,
          $$UsersTableTableOrderingComposer,
          $$UsersTableTableAnnotationComposer,
          $$UsersTableTableCreateCompanionBuilder,
          $$UsersTableTableUpdateCompanionBuilder,
          (
            UsersTableData,
            BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
          ),
          UsersTableData,
          PrefetchHooks Function()
        > {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> remoteUserId = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> gameName = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> experiencePoints = const Value.absent(),
                Value<int> totalWorkouts = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> lastModified = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => UsersTableCompanion(
                id: id,
                remoteUserId: remoteUserId,
                email: email,
                gameName: gameName,
                level: level,
                experiencePoints: experiencePoints,
                totalWorkouts: totalWorkouts,
                syncStatus: syncStatus,
                lastModified: lastModified,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> remoteUserId = const Value.absent(),
                required String email,
                required String gameName,
                required int level,
                Value<int> experiencePoints = const Value.absent(),
                Value<int> totalWorkouts = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> lastModified = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => UsersTableCompanion.insert(
                id: id,
                remoteUserId: remoteUserId,
                email: email,
                gameName: gameName,
                level: level,
                experiencePoints: experiencePoints,
                totalWorkouts: totalWorkouts,
                syncStatus: syncStatus,
                lastModified: lastModified,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTableTable,
      UsersTableData,
      $$UsersTableTableFilterComposer,
      $$UsersTableTableOrderingComposer,
      $$UsersTableTableAnnotationComposer,
      $$UsersTableTableCreateCompanionBuilder,
      $$UsersTableTableUpdateCompanionBuilder,
      (
        UsersTableData,
        BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
      ),
      UsersTableData,
      PrefetchHooks Function()
    >;
typedef $$UserProfileTableTableCreateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<int> id,
      required int userId,
      required double weight,
      required double height,
      Value<int?> age,
      Value<String?> issues,
      Value<String?> pains,
      Value<String?> comments,
    });
typedef $$UserProfileTableTableUpdateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<double> weight,
      Value<double> height,
      Value<int?> age,
      Value<String?> issues,
      Value<String?> pains,
      Value<String?> comments,
    });

class $$UserProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issues => $composableBuilder(
    column: $table.issues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pains => $composableBuilder(
    column: $table.pains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comments => $composableBuilder(
    column: $table.comments,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issues => $composableBuilder(
    column: $table.issues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pains => $composableBuilder(
    column: $table.pains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comments => $composableBuilder(
    column: $table.comments,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get issues =>
      $composableBuilder(column: $table.issues, builder: (column) => column);

  GeneratedColumn<String> get pains =>
      $composableBuilder(column: $table.pains, builder: (column) => column);

  GeneratedColumn<String> get comments =>
      $composableBuilder(column: $table.comments, builder: (column) => column);
}

class $$UserProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileTableData,
          $$UserProfileTableTableFilterComposer,
          $$UserProfileTableTableOrderingComposer,
          $$UserProfileTableTableAnnotationComposer,
          $$UserProfileTableTableCreateCompanionBuilder,
          $$UserProfileTableTableUpdateCompanionBuilder,
          (
            UserProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $UserProfileTableTable,
              UserProfileTableData
            >,
          ),
          UserProfileTableData,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableTableManager(
    _$AppDatabase db,
    $UserProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<String?> issues = const Value.absent(),
                Value<String?> pains = const Value.absent(),
                Value<String?> comments = const Value.absent(),
              }) => UserProfileTableCompanion(
                id: id,
                userId: userId,
                weight: weight,
                height: height,
                age: age,
                issues: issues,
                pains: pains,
                comments: comments,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required double weight,
                required double height,
                Value<int?> age = const Value.absent(),
                Value<String?> issues = const Value.absent(),
                Value<String?> pains = const Value.absent(),
                Value<String?> comments = const Value.absent(),
              }) => UserProfileTableCompanion.insert(
                id: id,
                userId: userId,
                weight: weight,
                height: height,
                age: age,
                issues: issues,
                pains: pains,
                comments: comments,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfileTableTable,
      UserProfileTableData,
      $$UserProfileTableTableFilterComposer,
      $$UserProfileTableTableOrderingComposer,
      $$UserProfileTableTableAnnotationComposer,
      $$UserProfileTableTableCreateCompanionBuilder,
      $$UserProfileTableTableUpdateCompanionBuilder,
      (
        UserProfileTableData,
        BaseReferences<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileTableData
        >,
      ),
      UserProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$ExerciseTableTableCreateCompanionBuilder =
    ExerciseTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> type,
    });
typedef $$ExerciseTableTableUpdateCompanionBuilder =
    ExerciseTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> type,
    });

class $$ExerciseTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseTableTable> {
  $$ExerciseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseTableTable> {
  $$ExerciseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseTableTable> {
  $$ExerciseTableTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$ExerciseTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseTableTable,
          ExerciseTableData,
          $$ExerciseTableTableFilterComposer,
          $$ExerciseTableTableOrderingComposer,
          $$ExerciseTableTableAnnotationComposer,
          $$ExerciseTableTableCreateCompanionBuilder,
          $$ExerciseTableTableUpdateCompanionBuilder,
          (
            ExerciseTableData,
            BaseReferences<
              _$AppDatabase,
              $ExerciseTableTable,
              ExerciseTableData
            >,
          ),
          ExerciseTableData,
          PrefetchHooks Function()
        > {
  $$ExerciseTableTableTableManager(_$AppDatabase db, $ExerciseTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> type = const Value.absent(),
              }) => ExerciseTableCompanion(
                id: id,
                name: name,
                description: description,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> type = const Value.absent(),
              }) => ExerciseTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseTableTable,
      ExerciseTableData,
      $$ExerciseTableTableFilterComposer,
      $$ExerciseTableTableOrderingComposer,
      $$ExerciseTableTableAnnotationComposer,
      $$ExerciseTableTableCreateCompanionBuilder,
      $$ExerciseTableTableUpdateCompanionBuilder,
      (
        ExerciseTableData,
        BaseReferences<_$AppDatabase, $ExerciseTableTable, ExerciseTableData>,
      ),
      ExerciseTableData,
      PrefetchHooks Function()
    >;
typedef $$RoutineTableTableCreateCompanionBuilder =
    RoutineTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
    });
typedef $$RoutineTableTableUpdateCompanionBuilder =
    RoutineTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
    });

class $$RoutineTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineTableTable> {
  $$RoutineTableTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$RoutineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineTableTable,
          RoutineTableData,
          $$RoutineTableTableFilterComposer,
          $$RoutineTableTableOrderingComposer,
          $$RoutineTableTableAnnotationComposer,
          $$RoutineTableTableCreateCompanionBuilder,
          $$RoutineTableTableUpdateCompanionBuilder,
          (
            RoutineTableData,
            BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTableData>,
          ),
          RoutineTableData,
          PrefetchHooks Function()
        > {
  $$RoutineTableTableTableManager(_$AppDatabase db, $RoutineTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => RoutineTableCompanion(
                id: id,
                name: name,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
              }) => RoutineTableCompanion.insert(
                id: id,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineTableTable,
      RoutineTableData,
      $$RoutineTableTableFilterComposer,
      $$RoutineTableTableOrderingComposer,
      $$RoutineTableTableAnnotationComposer,
      $$RoutineTableTableCreateCompanionBuilder,
      $$RoutineTableTableUpdateCompanionBuilder,
      (
        RoutineTableData,
        BaseReferences<_$AppDatabase, $RoutineTableTable, RoutineTableData>,
      ),
      RoutineTableData,
      PrefetchHooks Function()
    >;
typedef $$RoutineExerciseTableTableCreateCompanionBuilder =
    RoutineExerciseTableCompanion Function({
      Value<int> id,
      required int routineId,
      required int exerciseId,
      Value<int?> reps,
      Value<int?> duration,
    });
typedef $$RoutineExerciseTableTableUpdateCompanionBuilder =
    RoutineExerciseTableCompanion Function({
      Value<int> id,
      Value<int> routineId,
      Value<int> exerciseId,
      Value<int?> reps,
      Value<int?> duration,
    });

class $$RoutineExerciseTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineExerciseTableTable> {
  $$RoutineExerciseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineExerciseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineExerciseTableTable> {
  $$RoutineExerciseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineExerciseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineExerciseTableTable> {
  $$RoutineExerciseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<int> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);
}

class $$RoutineExerciseTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineExerciseTableTable,
          RoutineExerciseTableData,
          $$RoutineExerciseTableTableFilterComposer,
          $$RoutineExerciseTableTableOrderingComposer,
          $$RoutineExerciseTableTableAnnotationComposer,
          $$RoutineExerciseTableTableCreateCompanionBuilder,
          $$RoutineExerciseTableTableUpdateCompanionBuilder,
          (
            RoutineExerciseTableData,
            BaseReferences<
              _$AppDatabase,
              $RoutineExerciseTableTable,
              RoutineExerciseTableData
            >,
          ),
          RoutineExerciseTableData,
          PrefetchHooks Function()
        > {
  $$RoutineExerciseTableTableTableManager(
    _$AppDatabase db,
    $RoutineExerciseTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineExerciseTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineExerciseTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RoutineExerciseTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
              }) => RoutineExerciseTableCompanion(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                reps: reps,
                duration: duration,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int routineId,
                required int exerciseId,
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
              }) => RoutineExerciseTableCompanion.insert(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                reps: reps,
                duration: duration,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineExerciseTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineExerciseTableTable,
      RoutineExerciseTableData,
      $$RoutineExerciseTableTableFilterComposer,
      $$RoutineExerciseTableTableOrderingComposer,
      $$RoutineExerciseTableTableAnnotationComposer,
      $$RoutineExerciseTableTableCreateCompanionBuilder,
      $$RoutineExerciseTableTableUpdateCompanionBuilder,
      (
        RoutineExerciseTableData,
        BaseReferences<
          _$AppDatabase,
          $RoutineExerciseTableTable,
          RoutineExerciseTableData
        >,
      ),
      RoutineExerciseTableData,
      PrefetchHooks Function()
    >;
typedef $$UserRoutineTableTableCreateCompanionBuilder =
    UserRoutineTableCompanion Function({
      Value<int> id,
      required int userId,
      required String title,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$UserRoutineTableTableUpdateCompanionBuilder =
    UserRoutineTableCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> title,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$UserRoutineTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserRoutineTableTable> {
  $$UserRoutineTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserRoutineTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRoutineTableTable> {
  $$UserRoutineTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserRoutineTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRoutineTableTable> {
  $$UserRoutineTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserRoutineTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserRoutineTableTable,
          UserRoutineTableData,
          $$UserRoutineTableTableFilterComposer,
          $$UserRoutineTableTableOrderingComposer,
          $$UserRoutineTableTableAnnotationComposer,
          $$UserRoutineTableTableCreateCompanionBuilder,
          $$UserRoutineTableTableUpdateCompanionBuilder,
          (
            UserRoutineTableData,
            BaseReferences<
              _$AppDatabase,
              $UserRoutineTableTable,
              UserRoutineTableData
            >,
          ),
          UserRoutineTableData,
          PrefetchHooks Function()
        > {
  $$UserRoutineTableTableTableManager(
    _$AppDatabase db,
    $UserRoutineTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRoutineTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserRoutineTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserRoutineTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserRoutineTableCompanion(
                id: id,
                userId: userId,
                title: title,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String title,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UserRoutineTableCompanion.insert(
                id: id,
                userId: userId,
                title: title,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserRoutineTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserRoutineTableTable,
      UserRoutineTableData,
      $$UserRoutineTableTableFilterComposer,
      $$UserRoutineTableTableOrderingComposer,
      $$UserRoutineTableTableAnnotationComposer,
      $$UserRoutineTableTableCreateCompanionBuilder,
      $$UserRoutineTableTableUpdateCompanionBuilder,
      (
        UserRoutineTableData,
        BaseReferences<
          _$AppDatabase,
          $UserRoutineTableTable,
          UserRoutineTableData
        >,
      ),
      UserRoutineTableData,
      PrefetchHooks Function()
    >;
typedef $$UserRoutineExerciseTableTableCreateCompanionBuilder =
    UserRoutineExerciseTableCompanion Function({
      Value<int> id,
      required int userRoutineId,
      required int exerciseId,
      Value<int?> reps,
      Value<int?> duration,
      Value<double?> intensity,
    });
typedef $$UserRoutineExerciseTableTableUpdateCompanionBuilder =
    UserRoutineExerciseTableCompanion Function({
      Value<int> id,
      Value<int> userRoutineId,
      Value<int> exerciseId,
      Value<int?> reps,
      Value<int?> duration,
      Value<double?> intensity,
    });

class $$UserRoutineExerciseTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserRoutineExerciseTableTable> {
  $$UserRoutineExerciseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userRoutineId => $composableBuilder(
    column: $table.userRoutineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserRoutineExerciseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRoutineExerciseTableTable> {
  $$UserRoutineExerciseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userRoutineId => $composableBuilder(
    column: $table.userRoutineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserRoutineExerciseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRoutineExerciseTableTable> {
  $$UserRoutineExerciseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userRoutineId => $composableBuilder(
    column: $table.userRoutineId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);
}

class $$UserRoutineExerciseTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserRoutineExerciseTableTable,
          UserRoutineExerciseTableData,
          $$UserRoutineExerciseTableTableFilterComposer,
          $$UserRoutineExerciseTableTableOrderingComposer,
          $$UserRoutineExerciseTableTableAnnotationComposer,
          $$UserRoutineExerciseTableTableCreateCompanionBuilder,
          $$UserRoutineExerciseTableTableUpdateCompanionBuilder,
          (
            UserRoutineExerciseTableData,
            BaseReferences<
              _$AppDatabase,
              $UserRoutineExerciseTableTable,
              UserRoutineExerciseTableData
            >,
          ),
          UserRoutineExerciseTableData,
          PrefetchHooks Function()
        > {
  $$UserRoutineExerciseTableTableTableManager(
    _$AppDatabase db,
    $UserRoutineExerciseTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRoutineExerciseTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserRoutineExerciseTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserRoutineExerciseTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userRoutineId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<double?> intensity = const Value.absent(),
              }) => UserRoutineExerciseTableCompanion(
                id: id,
                userRoutineId: userRoutineId,
                exerciseId: exerciseId,
                reps: reps,
                duration: duration,
                intensity: intensity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userRoutineId,
                required int exerciseId,
                Value<int?> reps = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<double?> intensity = const Value.absent(),
              }) => UserRoutineExerciseTableCompanion.insert(
                id: id,
                userRoutineId: userRoutineId,
                exerciseId: exerciseId,
                reps: reps,
                duration: duration,
                intensity: intensity,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserRoutineExerciseTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserRoutineExerciseTableTable,
      UserRoutineExerciseTableData,
      $$UserRoutineExerciseTableTableFilterComposer,
      $$UserRoutineExerciseTableTableOrderingComposer,
      $$UserRoutineExerciseTableTableAnnotationComposer,
      $$UserRoutineExerciseTableTableCreateCompanionBuilder,
      $$UserRoutineExerciseTableTableUpdateCompanionBuilder,
      (
        UserRoutineExerciseTableData,
        BaseReferences<
          _$AppDatabase,
          $UserRoutineExerciseTableTable,
          UserRoutineExerciseTableData
        >,
      ),
      UserRoutineExerciseTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$UserProfileTableTableTableManager get userProfileTable =>
      $$UserProfileTableTableTableManager(_db, _db.userProfileTable);
  $$ExerciseTableTableTableManager get exerciseTable =>
      $$ExerciseTableTableTableManager(_db, _db.exerciseTable);
  $$RoutineTableTableTableManager get routineTable =>
      $$RoutineTableTableTableManager(_db, _db.routineTable);
  $$RoutineExerciseTableTableTableManager get routineExerciseTable =>
      $$RoutineExerciseTableTableTableManager(_db, _db.routineExerciseTable);
  $$UserRoutineTableTableTableManager get userRoutineTable =>
      $$UserRoutineTableTableTableManager(_db, _db.userRoutineTable);
  $$UserRoutineExerciseTableTableTableManager get userRoutineExerciseTable =>
      $$UserRoutineExerciseTableTableTableManager(
        _db,
        _db.userRoutineExerciseTable,
      );
}
