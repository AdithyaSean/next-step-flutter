// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students
    with TableInfo<$StudentsTable, StudentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactMeta =
      const VerificationMeta('contact');
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
      'contact', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
      'school', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _districtMeta =
      const VerificationMeta('district');
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
      'district', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _olResultsMeta =
      const VerificationMeta('olResults');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      olResults = GeneratedColumn<String>('ol_results', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $StudentsTable.$converterolResults);
  static const VerificationMeta _alResultsMeta =
      const VerificationMeta('alResults');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      alResults = GeneratedColumn<String>('al_results', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $StudentsTable.$converteralResults);
  static const VerificationMeta _streamMeta = const VerificationMeta('stream');
  @override
  late final GeneratedColumn<String> stream = GeneratedColumn<String>(
      'stream', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _zScoreMeta = const VerificationMeta('zScore');
  @override
  late final GeneratedColumn<double> zScore = GeneratedColumn<double>(
      'z_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _interestsMeta =
      const VerificationMeta('interests');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> interests =
      GeneratedColumn<String>('interests', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($StudentsTable.$converterinterests);
  static const VerificationMeta _skillsMeta = const VerificationMeta('skills');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> skills =
      GeneratedColumn<String>('skills', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($StudentsTable.$converterskills);
  static const VerificationMeta _strengthsMeta =
      const VerificationMeta('strengths');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> strengths =
      GeneratedColumn<String>('strengths', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($StudentsTable.$converterstrengths);
  static const VerificationMeta _predictionsMeta =
      const VerificationMeta('predictions');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, Map<String, dynamic>>,
      String> predictions = GeneratedColumn<String>(
          'predictions', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true)
      .withConverter<Map<String, Map<String, dynamic>>>(
          $StudentsTable.$converterpredictions);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        contact,
        school,
        district,
        password,
        olResults,
        alResults,
        stream,
        zScore,
        interests,
        skills,
        strengths,
        predictions
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<StudentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('contact')) {
      context.handle(_contactMeta,
          contact.isAcceptableOrUnknown(data['contact']!, _contactMeta));
    }
    if (data.containsKey('school')) {
      context.handle(_schoolMeta,
          school.isAcceptableOrUnknown(data['school']!, _schoolMeta));
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    } else if (isInserting) {
      context.missing(_districtMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    context.handle(_olResultsMeta, const VerificationResult.success());
    context.handle(_alResultsMeta, const VerificationResult.success());
    if (data.containsKey('stream')) {
      context.handle(_streamMeta,
          stream.isAcceptableOrUnknown(data['stream']!, _streamMeta));
    }
    if (data.containsKey('z_score')) {
      context.handle(_zScoreMeta,
          zScore.isAcceptableOrUnknown(data['z_score']!, _zScoreMeta));
    }
    context.handle(_interestsMeta, const VerificationResult.success());
    context.handle(_skillsMeta, const VerificationResult.success());
    context.handle(_strengthsMeta, const VerificationResult.success());
    context.handle(_predictionsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      contact: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact']),
      school: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}school']),
      district: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}district'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      olResults: $StudentsTable.$converterolResults.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ol_results'])!),
      alResults: $StudentsTable.$converteralResults.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}al_results'])!),
      stream: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stream']),
      zScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}z_score']),
      interests: $StudentsTable.$converterinterests.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}interests'])!),
      skills: $StudentsTable.$converterskills.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skills'])!),
      strengths: $StudentsTable.$converterstrengths.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strengths'])!),
      predictions: $StudentsTable.$converterpredictions.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}predictions'])!),
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $converterolResults =
      const MapConverter<String, String>();
  static TypeConverter<Map<String, String>, String> $converteralResults =
      const MapConverter<String, String>();
  static TypeConverter<List<String>, String> $converterinterests =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converterskills =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converterstrengths =
      const ListConverter<String>();
  static TypeConverter<Map<String, Map<String, dynamic>>, String>
      $converterpredictions =
      const MapConverter<String, Map<String, dynamic>>();
}

class StudentData extends DataClass implements Insertable<StudentData> {
  final String id;
  final String name;
  final String email;
  final String? contact;
  final String? school;
  final String district;
  final String password;
  final Map<String, String> olResults;
  final Map<String, String> alResults;
  final String? stream;
  final double? zScore;
  final List<String> interests;
  final List<String> skills;
  final List<String> strengths;
  final Map<String, Map<String, dynamic>> predictions;
  const StudentData(
      {required this.id,
      required this.name,
      required this.email,
      this.contact,
      this.school,
      required this.district,
      required this.password,
      required this.olResults,
      required this.alResults,
      this.stream,
      this.zScore,
      required this.interests,
      required this.skills,
      required this.strengths,
      required this.predictions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || contact != null) {
      map['contact'] = Variable<String>(contact);
    }
    if (!nullToAbsent || school != null) {
      map['school'] = Variable<String>(school);
    }
    map['district'] = Variable<String>(district);
    map['password'] = Variable<String>(password);
    {
      map['ol_results'] =
          Variable<String>($StudentsTable.$converterolResults.toSql(olResults));
    }
    {
      map['al_results'] =
          Variable<String>($StudentsTable.$converteralResults.toSql(alResults));
    }
    if (!nullToAbsent || stream != null) {
      map['stream'] = Variable<String>(stream);
    }
    if (!nullToAbsent || zScore != null) {
      map['z_score'] = Variable<double>(zScore);
    }
    {
      map['interests'] =
          Variable<String>($StudentsTable.$converterinterests.toSql(interests));
    }
    {
      map['skills'] =
          Variable<String>($StudentsTable.$converterskills.toSql(skills));
    }
    {
      map['strengths'] =
          Variable<String>($StudentsTable.$converterstrengths.toSql(strengths));
    }
    {
      map['predictions'] = Variable<String>(
          $StudentsTable.$converterpredictions.toSql(predictions));
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      school:
          school == null && nullToAbsent ? const Value.absent() : Value(school),
      district: Value(district),
      password: Value(password),
      olResults: Value(olResults),
      alResults: Value(alResults),
      stream:
          stream == null && nullToAbsent ? const Value.absent() : Value(stream),
      zScore:
          zScore == null && nullToAbsent ? const Value.absent() : Value(zScore),
      interests: Value(interests),
      skills: Value(skills),
      strengths: Value(strengths),
      predictions: Value(predictions),
    );
  }

  factory StudentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      contact: serializer.fromJson<String?>(json['contact']),
      school: serializer.fromJson<String?>(json['school']),
      district: serializer.fromJson<String>(json['district']),
      password: serializer.fromJson<String>(json['password']),
      olResults: serializer.fromJson<Map<String, String>>(json['olResults']),
      alResults: serializer.fromJson<Map<String, String>>(json['alResults']),
      stream: serializer.fromJson<String?>(json['stream']),
      zScore: serializer.fromJson<double?>(json['zScore']),
      interests: serializer.fromJson<List<String>>(json['interests']),
      skills: serializer.fromJson<List<String>>(json['skills']),
      strengths: serializer.fromJson<List<String>>(json['strengths']),
      predictions: serializer
          .fromJson<Map<String, Map<String, dynamic>>>(json['predictions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'contact': serializer.toJson<String?>(contact),
      'school': serializer.toJson<String?>(school),
      'district': serializer.toJson<String>(district),
      'password': serializer.toJson<String>(password),
      'olResults': serializer.toJson<Map<String, String>>(olResults),
      'alResults': serializer.toJson<Map<String, String>>(alResults),
      'stream': serializer.toJson<String?>(stream),
      'zScore': serializer.toJson<double?>(zScore),
      'interests': serializer.toJson<List<String>>(interests),
      'skills': serializer.toJson<List<String>>(skills),
      'strengths': serializer.toJson<List<String>>(strengths),
      'predictions':
          serializer.toJson<Map<String, Map<String, dynamic>>>(predictions),
    };
  }

  StudentData copyWith(
          {String? id,
          String? name,
          String? email,
          Value<String?> contact = const Value.absent(),
          Value<String?> school = const Value.absent(),
          String? district,
          String? password,
          Map<String, String>? olResults,
          Map<String, String>? alResults,
          Value<String?> stream = const Value.absent(),
          Value<double?> zScore = const Value.absent(),
          List<String>? interests,
          List<String>? skills,
          List<String>? strengths,
          Map<String, Map<String, dynamic>>? predictions}) =>
      StudentData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        contact: contact.present ? contact.value : this.contact,
        school: school.present ? school.value : this.school,
        district: district ?? this.district,
        password: password ?? this.password,
        olResults: olResults ?? this.olResults,
        alResults: alResults ?? this.alResults,
        stream: stream.present ? stream.value : this.stream,
        zScore: zScore.present ? zScore.value : this.zScore,
        interests: interests ?? this.interests,
        skills: skills ?? this.skills,
        strengths: strengths ?? this.strengths,
        predictions: predictions ?? this.predictions,
      );
  StudentData copyWithCompanion(StudentsCompanion data) {
    return StudentData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      contact: data.contact.present ? data.contact.value : this.contact,
      school: data.school.present ? data.school.value : this.school,
      district: data.district.present ? data.district.value : this.district,
      password: data.password.present ? data.password.value : this.password,
      olResults: data.olResults.present ? data.olResults.value : this.olResults,
      alResults: data.alResults.present ? data.alResults.value : this.alResults,
      stream: data.stream.present ? data.stream.value : this.stream,
      zScore: data.zScore.present ? data.zScore.value : this.zScore,
      interests: data.interests.present ? data.interests.value : this.interests,
      skills: data.skills.present ? data.skills.value : this.skills,
      strengths: data.strengths.present ? data.strengths.value : this.strengths,
      predictions:
          data.predictions.present ? data.predictions.value : this.predictions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('contact: $contact, ')
          ..write('school: $school, ')
          ..write('district: $district, ')
          ..write('password: $password, ')
          ..write('olResults: $olResults, ')
          ..write('alResults: $alResults, ')
          ..write('stream: $stream, ')
          ..write('zScore: $zScore, ')
          ..write('interests: $interests, ')
          ..write('skills: $skills, ')
          ..write('strengths: $strengths, ')
          ..write('predictions: $predictions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      email,
      contact,
      school,
      district,
      password,
      olResults,
      alResults,
      stream,
      zScore,
      interests,
      skills,
      strengths,
      predictions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.contact == this.contact &&
          other.school == this.school &&
          other.district == this.district &&
          other.password == this.password &&
          other.olResults == this.olResults &&
          other.alResults == this.alResults &&
          other.stream == this.stream &&
          other.zScore == this.zScore &&
          other.interests == this.interests &&
          other.skills == this.skills &&
          other.strengths == this.strengths &&
          other.predictions == this.predictions);
}

class StudentsCompanion extends UpdateCompanion<StudentData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> contact;
  final Value<String?> school;
  final Value<String> district;
  final Value<String> password;
  final Value<Map<String, String>> olResults;
  final Value<Map<String, String>> alResults;
  final Value<String?> stream;
  final Value<double?> zScore;
  final Value<List<String>> interests;
  final Value<List<String>> skills;
  final Value<List<String>> strengths;
  final Value<Map<String, Map<String, dynamic>>> predictions;
  final Value<int> rowid;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.contact = const Value.absent(),
    this.school = const Value.absent(),
    this.district = const Value.absent(),
    this.password = const Value.absent(),
    this.olResults = const Value.absent(),
    this.alResults = const Value.absent(),
    this.stream = const Value.absent(),
    this.zScore = const Value.absent(),
    this.interests = const Value.absent(),
    this.skills = const Value.absent(),
    this.strengths = const Value.absent(),
    this.predictions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentsCompanion.insert({
    required String id,
    required String name,
    required String email,
    this.contact = const Value.absent(),
    this.school = const Value.absent(),
    required String district,
    required String password,
    required Map<String, String> olResults,
    required Map<String, String> alResults,
    this.stream = const Value.absent(),
    this.zScore = const Value.absent(),
    required List<String> interests,
    required List<String> skills,
    required List<String> strengths,
    required Map<String, Map<String, dynamic>> predictions,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        district = Value(district),
        password = Value(password),
        olResults = Value(olResults),
        alResults = Value(alResults),
        interests = Value(interests),
        skills = Value(skills),
        strengths = Value(strengths),
        predictions = Value(predictions);
  static Insertable<StudentData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? contact,
    Expression<String>? school,
    Expression<String>? district,
    Expression<String>? password,
    Expression<String>? olResults,
    Expression<String>? alResults,
    Expression<String>? stream,
    Expression<double>? zScore,
    Expression<String>? interests,
    Expression<String>? skills,
    Expression<String>? strengths,
    Expression<String>? predictions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (contact != null) 'contact': contact,
      if (school != null) 'school': school,
      if (district != null) 'district': district,
      if (password != null) 'password': password,
      if (olResults != null) 'ol_results': olResults,
      if (alResults != null) 'al_results': alResults,
      if (stream != null) 'stream': stream,
      if (zScore != null) 'z_score': zScore,
      if (interests != null) 'interests': interests,
      if (skills != null) 'skills': skills,
      if (strengths != null) 'strengths': strengths,
      if (predictions != null) 'predictions': predictions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String?>? contact,
      Value<String?>? school,
      Value<String>? district,
      Value<String>? password,
      Value<Map<String, String>>? olResults,
      Value<Map<String, String>>? alResults,
      Value<String?>? stream,
      Value<double?>? zScore,
      Value<List<String>>? interests,
      Value<List<String>>? skills,
      Value<List<String>>? strengths,
      Value<Map<String, Map<String, dynamic>>>? predictions,
      Value<int>? rowid}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      school: school ?? this.school,
      district: district ?? this.district,
      password: password ?? this.password,
      olResults: olResults ?? this.olResults,
      alResults: alResults ?? this.alResults,
      stream: stream ?? this.stream,
      zScore: zScore ?? this.zScore,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
      strengths: strengths ?? this.strengths,
      predictions: predictions ?? this.predictions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (olResults.present) {
      map['ol_results'] = Variable<String>(
          $StudentsTable.$converterolResults.toSql(olResults.value));
    }
    if (alResults.present) {
      map['al_results'] = Variable<String>(
          $StudentsTable.$converteralResults.toSql(alResults.value));
    }
    if (stream.present) {
      map['stream'] = Variable<String>(stream.value);
    }
    if (zScore.present) {
      map['z_score'] = Variable<double>(zScore.value);
    }
    if (interests.present) {
      map['interests'] = Variable<String>(
          $StudentsTable.$converterinterests.toSql(interests.value));
    }
    if (skills.present) {
      map['skills'] =
          Variable<String>($StudentsTable.$converterskills.toSql(skills.value));
    }
    if (strengths.present) {
      map['strengths'] = Variable<String>(
          $StudentsTable.$converterstrengths.toSql(strengths.value));
    }
    if (predictions.present) {
      map['predictions'] = Variable<String>(
          $StudentsTable.$converterpredictions.toSql(predictions.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('contact: $contact, ')
          ..write('school: $school, ')
          ..write('district: $district, ')
          ..write('password: $password, ')
          ..write('olResults: $olResults, ')
          ..write('alResults: $alResults, ')
          ..write('stream: $stream, ')
          ..write('zScore: $zScore, ')
          ..write('interests: $interests, ')
          ..write('skills: $skills, ')
          ..write('strengths: $strengths, ')
          ..write('predictions: $predictions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StreamsTable extends Streams with TableInfo<$StreamsTable, StreamData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requiredOLSubjectsMeta =
      const VerificationMeta('requiredOLSubjects');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      requiredOLSubjects = GeneratedColumn<String>(
              'required_o_l_subjects', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $StreamsTable.$converterrequiredOLSubjects);
  static const VerificationMeta _minimumOLGradesMeta =
      const VerificationMeta('minimumOLGrades');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      minimumOLGrades = GeneratedColumn<String>(
              'minimum_o_l_grades', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $StreamsTable.$converterminimumOLGrades);
  static const VerificationMeta _possibleCoursesMeta =
      const VerificationMeta('possibleCourses');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      possibleCourses = GeneratedColumn<String>(
              'possible_courses', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $StreamsTable.$converterpossibleCourses);
  static const VerificationMeta _relatedCareersMeta =
      const VerificationMeta('relatedCareers');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      relatedCareers = GeneratedColumn<String>(
              'related_careers', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($StreamsTable.$converterrelatedCareers);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        requiredOLSubjects,
        minimumOLGrades,
        possibleCourses,
        relatedCareers
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streams';
  @override
  VerificationContext validateIntegrity(Insertable<StreamData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    context.handle(_requiredOLSubjectsMeta, const VerificationResult.success());
    context.handle(_minimumOLGradesMeta, const VerificationResult.success());
    context.handle(_possibleCoursesMeta, const VerificationResult.success());
    context.handle(_relatedCareersMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StreamData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StreamData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      requiredOLSubjects: $StreamsTable.$converterrequiredOLSubjects.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}required_o_l_subjects'])!),
      minimumOLGrades: $StreamsTable.$converterminimumOLGrades.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}minimum_o_l_grades'])!),
      possibleCourses: $StreamsTable.$converterpossibleCourses.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}possible_courses'])!),
      relatedCareers: $StreamsTable.$converterrelatedCareers.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}related_careers'])!),
    );
  }

  @override
  $StreamsTable createAlias(String alias) {
    return $StreamsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterrequiredOLSubjects =
      const ListConverter<String>();
  static TypeConverter<Map<String, String>, String> $converterminimumOLGrades =
      const MapConverter<String, String>();
  static TypeConverter<Map<String, String>, String> $converterpossibleCourses =
      const MapConverter<String, String>();
  static TypeConverter<List<String>, String> $converterrelatedCareers =
      const ListConverter<String>();
}

class StreamData extends DataClass implements Insertable<StreamData> {
  final String id;
  final String name;
  final String description;
  final List<String> requiredOLSubjects;
  final Map<String, String> minimumOLGrades;
  final Map<String, String> possibleCourses;
  final List<String> relatedCareers;
  const StreamData(
      {required this.id,
      required this.name,
      required this.description,
      required this.requiredOLSubjects,
      required this.minimumOLGrades,
      required this.possibleCourses,
      required this.relatedCareers});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    {
      map['required_o_l_subjects'] = Variable<String>(
          $StreamsTable.$converterrequiredOLSubjects.toSql(requiredOLSubjects));
    }
    {
      map['minimum_o_l_grades'] = Variable<String>(
          $StreamsTable.$converterminimumOLGrades.toSql(minimumOLGrades));
    }
    {
      map['possible_courses'] = Variable<String>(
          $StreamsTable.$converterpossibleCourses.toSql(possibleCourses));
    }
    {
      map['related_careers'] = Variable<String>(
          $StreamsTable.$converterrelatedCareers.toSql(relatedCareers));
    }
    return map;
  }

  StreamsCompanion toCompanion(bool nullToAbsent) {
    return StreamsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      requiredOLSubjects: Value(requiredOLSubjects),
      minimumOLGrades: Value(minimumOLGrades),
      possibleCourses: Value(possibleCourses),
      relatedCareers: Value(relatedCareers),
    );
  }

  factory StreamData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StreamData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      requiredOLSubjects:
          serializer.fromJson<List<String>>(json['requiredOLSubjects']),
      minimumOLGrades:
          serializer.fromJson<Map<String, String>>(json['minimumOLGrades']),
      possibleCourses:
          serializer.fromJson<Map<String, String>>(json['possibleCourses']),
      relatedCareers: serializer.fromJson<List<String>>(json['relatedCareers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'requiredOLSubjects': serializer.toJson<List<String>>(requiredOLSubjects),
      'minimumOLGrades':
          serializer.toJson<Map<String, String>>(minimumOLGrades),
      'possibleCourses':
          serializer.toJson<Map<String, String>>(possibleCourses),
      'relatedCareers': serializer.toJson<List<String>>(relatedCareers),
    };
  }

  StreamData copyWith(
          {String? id,
          String? name,
          String? description,
          List<String>? requiredOLSubjects,
          Map<String, String>? minimumOLGrades,
          Map<String, String>? possibleCourses,
          List<String>? relatedCareers}) =>
      StreamData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        requiredOLSubjects: requiredOLSubjects ?? this.requiredOLSubjects,
        minimumOLGrades: minimumOLGrades ?? this.minimumOLGrades,
        possibleCourses: possibleCourses ?? this.possibleCourses,
        relatedCareers: relatedCareers ?? this.relatedCareers,
      );
  StreamData copyWithCompanion(StreamsCompanion data) {
    return StreamData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      requiredOLSubjects: data.requiredOLSubjects.present
          ? data.requiredOLSubjects.value
          : this.requiredOLSubjects,
      minimumOLGrades: data.minimumOLGrades.present
          ? data.minimumOLGrades.value
          : this.minimumOLGrades,
      possibleCourses: data.possibleCourses.present
          ? data.possibleCourses.value
          : this.possibleCourses,
      relatedCareers: data.relatedCareers.present
          ? data.relatedCareers.value
          : this.relatedCareers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StreamData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('requiredOLSubjects: $requiredOLSubjects, ')
          ..write('minimumOLGrades: $minimumOLGrades, ')
          ..write('possibleCourses: $possibleCourses, ')
          ..write('relatedCareers: $relatedCareers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, requiredOLSubjects,
      minimumOLGrades, possibleCourses, relatedCareers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StreamData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.requiredOLSubjects == this.requiredOLSubjects &&
          other.minimumOLGrades == this.minimumOLGrades &&
          other.possibleCourses == this.possibleCourses &&
          other.relatedCareers == this.relatedCareers);
}

class StreamsCompanion extends UpdateCompanion<StreamData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<List<String>> requiredOLSubjects;
  final Value<Map<String, String>> minimumOLGrades;
  final Value<Map<String, String>> possibleCourses;
  final Value<List<String>> relatedCareers;
  final Value<int> rowid;
  const StreamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.requiredOLSubjects = const Value.absent(),
    this.minimumOLGrades = const Value.absent(),
    this.possibleCourses = const Value.absent(),
    this.relatedCareers = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StreamsCompanion.insert({
    required String id,
    required String name,
    required String description,
    required List<String> requiredOLSubjects,
    required Map<String, String> minimumOLGrades,
    required Map<String, String> possibleCourses,
    required List<String> relatedCareers,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        requiredOLSubjects = Value(requiredOLSubjects),
        minimumOLGrades = Value(minimumOLGrades),
        possibleCourses = Value(possibleCourses),
        relatedCareers = Value(relatedCareers);
  static Insertable<StreamData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? requiredOLSubjects,
    Expression<String>? minimumOLGrades,
    Expression<String>? possibleCourses,
    Expression<String>? relatedCareers,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (requiredOLSubjects != null)
        'required_o_l_subjects': requiredOLSubjects,
      if (minimumOLGrades != null) 'minimum_o_l_grades': minimumOLGrades,
      if (possibleCourses != null) 'possible_courses': possibleCourses,
      if (relatedCareers != null) 'related_careers': relatedCareers,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StreamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<List<String>>? requiredOLSubjects,
      Value<Map<String, String>>? minimumOLGrades,
      Value<Map<String, String>>? possibleCourses,
      Value<List<String>>? relatedCareers,
      Value<int>? rowid}) {
    return StreamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      requiredOLSubjects: requiredOLSubjects ?? this.requiredOLSubjects,
      minimumOLGrades: minimumOLGrades ?? this.minimumOLGrades,
      possibleCourses: possibleCourses ?? this.possibleCourses,
      relatedCareers: relatedCareers ?? this.relatedCareers,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (requiredOLSubjects.present) {
      map['required_o_l_subjects'] = Variable<String>($StreamsTable
          .$converterrequiredOLSubjects
          .toSql(requiredOLSubjects.value));
    }
    if (minimumOLGrades.present) {
      map['minimum_o_l_grades'] = Variable<String>(
          $StreamsTable.$converterminimumOLGrades.toSql(minimumOLGrades.value));
    }
    if (possibleCourses.present) {
      map['possible_courses'] = Variable<String>(
          $StreamsTable.$converterpossibleCourses.toSql(possibleCourses.value));
    }
    if (relatedCareers.present) {
      map['related_careers'] = Variable<String>(
          $StreamsTable.$converterrelatedCareers.toSql(relatedCareers.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('requiredOLSubjects: $requiredOLSubjects, ')
          ..write('minimumOLGrades: $minimumOLGrades, ')
          ..write('possibleCourses: $possibleCourses, ')
          ..write('relatedCareers: $relatedCareers, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, CourseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
      'duration', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _streamIdMeta =
      const VerificationMeta('streamId');
  @override
  late final GeneratedColumn<String> streamId = GeneratedColumn<String>(
      'stream_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES streams (id)'));
  static const VerificationMeta _minimumALGradesMeta =
      const VerificationMeta('minimumALGrades');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      minimumALGrades = GeneratedColumn<String>(
              'minimum_a_l_grades', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $CoursesTable.$converterminimumALGrades);
  static const VerificationMeta _minimumZScoreMeta =
      const VerificationMeta('minimumZScore');
  @override
  late final GeneratedColumn<double> minimumZScore = GeneratedColumn<double>(
      'minimum_z_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _offeredByInstitutionsMeta =
      const VerificationMeta('offeredByInstitutions');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      offeredByInstitutions = GeneratedColumn<String>(
              'offered_by_institutions', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $CoursesTable.$converterofferedByInstitutions);
  static const VerificationMeta _relatedCareersMeta =
      const VerificationMeta('relatedCareers');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      relatedCareers = GeneratedColumn<String>(
              'related_careers', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($CoursesTable.$converterrelatedCareers);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        duration,
        streamId,
        minimumALGrades,
        minimumZScore,
        offeredByInstitutions,
        relatedCareers
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(Insertable<CourseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('stream_id')) {
      context.handle(_streamIdMeta,
          streamId.isAcceptableOrUnknown(data['stream_id']!, _streamIdMeta));
    } else if (isInserting) {
      context.missing(_streamIdMeta);
    }
    context.handle(_minimumALGradesMeta, const VerificationResult.success());
    if (data.containsKey('minimum_z_score')) {
      context.handle(
          _minimumZScoreMeta,
          minimumZScore.isAcceptableOrUnknown(
              data['minimum_z_score']!, _minimumZScoreMeta));
    } else if (isInserting) {
      context.missing(_minimumZScoreMeta);
    }
    context.handle(
        _offeredByInstitutionsMeta, const VerificationResult.success());
    context.handle(_relatedCareersMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}duration'])!,
      streamId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stream_id'])!,
      minimumALGrades: $CoursesTable.$converterminimumALGrades.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}minimum_a_l_grades'])!),
      minimumZScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}minimum_z_score'])!,
      offeredByInstitutions: $CoursesTable.$converterofferedByInstitutions
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}offered_by_institutions'])!),
      relatedCareers: $CoursesTable.$converterrelatedCareers.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}related_careers'])!),
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $converterminimumALGrades =
      const MapConverter<String, String>();
  static TypeConverter<List<String>, String> $converterofferedByInstitutions =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converterrelatedCareers =
      const ListConverter<String>();
}

class CourseData extends DataClass implements Insertable<CourseData> {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String streamId;
  final Map<String, String> minimumALGrades;
  final double minimumZScore;
  final List<String> offeredByInstitutions;
  final List<String> relatedCareers;
  const CourseData(
      {required this.id,
      required this.name,
      required this.description,
      required this.duration,
      required this.streamId,
      required this.minimumALGrades,
      required this.minimumZScore,
      required this.offeredByInstitutions,
      required this.relatedCareers});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['duration'] = Variable<String>(duration);
    map['stream_id'] = Variable<String>(streamId);
    {
      map['minimum_a_l_grades'] = Variable<String>(
          $CoursesTable.$converterminimumALGrades.toSql(minimumALGrades));
    }
    map['minimum_z_score'] = Variable<double>(minimumZScore);
    {
      map['offered_by_institutions'] = Variable<String>($CoursesTable
          .$converterofferedByInstitutions
          .toSql(offeredByInstitutions));
    }
    {
      map['related_careers'] = Variable<String>(
          $CoursesTable.$converterrelatedCareers.toSql(relatedCareers));
    }
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      duration: Value(duration),
      streamId: Value(streamId),
      minimumALGrades: Value(minimumALGrades),
      minimumZScore: Value(minimumZScore),
      offeredByInstitutions: Value(offeredByInstitutions),
      relatedCareers: Value(relatedCareers),
    );
  }

  factory CourseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      duration: serializer.fromJson<String>(json['duration']),
      streamId: serializer.fromJson<String>(json['streamId']),
      minimumALGrades:
          serializer.fromJson<Map<String, String>>(json['minimumALGrades']),
      minimumZScore: serializer.fromJson<double>(json['minimumZScore']),
      offeredByInstitutions:
          serializer.fromJson<List<String>>(json['offeredByInstitutions']),
      relatedCareers: serializer.fromJson<List<String>>(json['relatedCareers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'duration': serializer.toJson<String>(duration),
      'streamId': serializer.toJson<String>(streamId),
      'minimumALGrades':
          serializer.toJson<Map<String, String>>(minimumALGrades),
      'minimumZScore': serializer.toJson<double>(minimumZScore),
      'offeredByInstitutions':
          serializer.toJson<List<String>>(offeredByInstitutions),
      'relatedCareers': serializer.toJson<List<String>>(relatedCareers),
    };
  }

  CourseData copyWith(
          {String? id,
          String? name,
          String? description,
          String? duration,
          String? streamId,
          Map<String, String>? minimumALGrades,
          double? minimumZScore,
          List<String>? offeredByInstitutions,
          List<String>? relatedCareers}) =>
      CourseData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        streamId: streamId ?? this.streamId,
        minimumALGrades: minimumALGrades ?? this.minimumALGrades,
        minimumZScore: minimumZScore ?? this.minimumZScore,
        offeredByInstitutions:
            offeredByInstitutions ?? this.offeredByInstitutions,
        relatedCareers: relatedCareers ?? this.relatedCareers,
      );
  CourseData copyWithCompanion(CoursesCompanion data) {
    return CourseData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      duration: data.duration.present ? data.duration.value : this.duration,
      streamId: data.streamId.present ? data.streamId.value : this.streamId,
      minimumALGrades: data.minimumALGrades.present
          ? data.minimumALGrades.value
          : this.minimumALGrades,
      minimumZScore: data.minimumZScore.present
          ? data.minimumZScore.value
          : this.minimumZScore,
      offeredByInstitutions: data.offeredByInstitutions.present
          ? data.offeredByInstitutions.value
          : this.offeredByInstitutions,
      relatedCareers: data.relatedCareers.present
          ? data.relatedCareers.value
          : this.relatedCareers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('streamId: $streamId, ')
          ..write('minimumALGrades: $minimumALGrades, ')
          ..write('minimumZScore: $minimumZScore, ')
          ..write('offeredByInstitutions: $offeredByInstitutions, ')
          ..write('relatedCareers: $relatedCareers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, duration, streamId,
      minimumALGrades, minimumZScore, offeredByInstitutions, relatedCareers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.duration == this.duration &&
          other.streamId == this.streamId &&
          other.minimumALGrades == this.minimumALGrades &&
          other.minimumZScore == this.minimumZScore &&
          other.offeredByInstitutions == this.offeredByInstitutions &&
          other.relatedCareers == this.relatedCareers);
}

class CoursesCompanion extends UpdateCompanion<CourseData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> duration;
  final Value<String> streamId;
  final Value<Map<String, String>> minimumALGrades;
  final Value<double> minimumZScore;
  final Value<List<String>> offeredByInstitutions;
  final Value<List<String>> relatedCareers;
  final Value<int> rowid;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.duration = const Value.absent(),
    this.streamId = const Value.absent(),
    this.minimumALGrades = const Value.absent(),
    this.minimumZScore = const Value.absent(),
    this.offeredByInstitutions = const Value.absent(),
    this.relatedCareers = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursesCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String duration,
    required String streamId,
    required Map<String, String> minimumALGrades,
    required double minimumZScore,
    required List<String> offeredByInstitutions,
    required List<String> relatedCareers,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        duration = Value(duration),
        streamId = Value(streamId),
        minimumALGrades = Value(minimumALGrades),
        minimumZScore = Value(minimumZScore),
        offeredByInstitutions = Value(offeredByInstitutions),
        relatedCareers = Value(relatedCareers);
  static Insertable<CourseData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? duration,
    Expression<String>? streamId,
    Expression<String>? minimumALGrades,
    Expression<double>? minimumZScore,
    Expression<String>? offeredByInstitutions,
    Expression<String>? relatedCareers,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (duration != null) 'duration': duration,
      if (streamId != null) 'stream_id': streamId,
      if (minimumALGrades != null) 'minimum_a_l_grades': minimumALGrades,
      if (minimumZScore != null) 'minimum_z_score': minimumZScore,
      if (offeredByInstitutions != null)
        'offered_by_institutions': offeredByInstitutions,
      if (relatedCareers != null) 'related_careers': relatedCareers,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String>? duration,
      Value<String>? streamId,
      Value<Map<String, String>>? minimumALGrades,
      Value<double>? minimumZScore,
      Value<List<String>>? offeredByInstitutions,
      Value<List<String>>? relatedCareers,
      Value<int>? rowid}) {
    return CoursesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      streamId: streamId ?? this.streamId,
      minimumALGrades: minimumALGrades ?? this.minimumALGrades,
      minimumZScore: minimumZScore ?? this.minimumZScore,
      offeredByInstitutions:
          offeredByInstitutions ?? this.offeredByInstitutions,
      relatedCareers: relatedCareers ?? this.relatedCareers,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (streamId.present) {
      map['stream_id'] = Variable<String>(streamId.value);
    }
    if (minimumALGrades.present) {
      map['minimum_a_l_grades'] = Variable<String>(
          $CoursesTable.$converterminimumALGrades.toSql(minimumALGrades.value));
    }
    if (minimumZScore.present) {
      map['minimum_z_score'] = Variable<double>(minimumZScore.value);
    }
    if (offeredByInstitutions.present) {
      map['offered_by_institutions'] = Variable<String>($CoursesTable
          .$converterofferedByInstitutions
          .toSql(offeredByInstitutions.value));
    }
    if (relatedCareers.present) {
      map['related_careers'] = Variable<String>(
          $CoursesTable.$converterrelatedCareers.toSql(relatedCareers.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('streamId: $streamId, ')
          ..write('minimumALGrades: $minimumALGrades, ')
          ..write('minimumZScore: $minimumZScore, ')
          ..write('offeredByInstitutions: $offeredByInstitutions, ')
          ..write('relatedCareers: $relatedCareers, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareersTable extends Careers with TableInfo<$CareersTable, CareerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requiredSkillsMeta =
      const VerificationMeta('requiredSkills');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      requiredSkills = GeneratedColumn<String>(
              'required_skills', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($CareersTable.$converterrequiredSkills);
  static const VerificationMeta _relatedCoursesMeta =
      const VerificationMeta('relatedCourses');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      relatedCourses = GeneratedColumn<String>(
              'related_courses', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($CareersTable.$converterrelatedCourses);
  static const VerificationMeta _externalLinksMeta =
      const VerificationMeta('externalLinks');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      externalLinks = GeneratedColumn<String>(
              'external_links', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $CareersTable.$converterexternalLinks);
  @override
  List<GeneratedColumn> get $columns => [
        code,
        title,
        description,
        category,
        requiredSkills,
        relatedCourses,
        externalLinks
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'careers';
  @override
  VerificationContext validateIntegrity(Insertable<CareerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    context.handle(_requiredSkillsMeta, const VerificationResult.success());
    context.handle(_relatedCoursesMeta, const VerificationResult.success());
    context.handle(_externalLinksMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CareerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareerData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      requiredSkills: $CareersTable.$converterrequiredSkills.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}required_skills'])!),
      relatedCourses: $CareersTable.$converterrelatedCourses.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}related_courses'])!),
      externalLinks: $CareersTable.$converterexternalLinks.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}external_links'])!),
    );
  }

  @override
  $CareersTable createAlias(String alias) {
    return $CareersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterrequiredSkills =
      const ListConverter<String>();
  static TypeConverter<List<String>, String> $converterrelatedCourses =
      const ListConverter<String>();
  static TypeConverter<Map<String, String>, String> $converterexternalLinks =
      const MapConverter<String, String>();
}

class CareerData extends DataClass implements Insertable<CareerData> {
  final String code;
  final String title;
  final String description;
  final String category;
  final List<String> requiredSkills;
  final List<String> relatedCourses;
  final Map<String, String> externalLinks;
  const CareerData(
      {required this.code,
      required this.title,
      required this.description,
      required this.category,
      required this.requiredSkills,
      required this.relatedCourses,
      required this.externalLinks});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    {
      map['required_skills'] = Variable<String>(
          $CareersTable.$converterrequiredSkills.toSql(requiredSkills));
    }
    {
      map['related_courses'] = Variable<String>(
          $CareersTable.$converterrelatedCourses.toSql(relatedCourses));
    }
    {
      map['external_links'] = Variable<String>(
          $CareersTable.$converterexternalLinks.toSql(externalLinks));
    }
    return map;
  }

  CareersCompanion toCompanion(bool nullToAbsent) {
    return CareersCompanion(
      code: Value(code),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      requiredSkills: Value(requiredSkills),
      relatedCourses: Value(relatedCourses),
      externalLinks: Value(externalLinks),
    );
  }

  factory CareerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareerData(
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      requiredSkills: serializer.fromJson<List<String>>(json['requiredSkills']),
      relatedCourses: serializer.fromJson<List<String>>(json['relatedCourses']),
      externalLinks:
          serializer.fromJson<Map<String, String>>(json['externalLinks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'requiredSkills': serializer.toJson<List<String>>(requiredSkills),
      'relatedCourses': serializer.toJson<List<String>>(relatedCourses),
      'externalLinks': serializer.toJson<Map<String, String>>(externalLinks),
    };
  }

  CareerData copyWith(
          {String? code,
          String? title,
          String? description,
          String? category,
          List<String>? requiredSkills,
          List<String>? relatedCourses,
          Map<String, String>? externalLinks}) =>
      CareerData(
        code: code ?? this.code,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        requiredSkills: requiredSkills ?? this.requiredSkills,
        relatedCourses: relatedCourses ?? this.relatedCourses,
        externalLinks: externalLinks ?? this.externalLinks,
      );
  CareerData copyWithCompanion(CareersCompanion data) {
    return CareerData(
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      requiredSkills: data.requiredSkills.present
          ? data.requiredSkills.value
          : this.requiredSkills,
      relatedCourses: data.relatedCourses.present
          ? data.relatedCourses.value
          : this.relatedCourses,
      externalLinks: data.externalLinks.present
          ? data.externalLinks.value
          : this.externalLinks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareerData(')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('requiredSkills: $requiredSkills, ')
          ..write('relatedCourses: $relatedCourses, ')
          ..write('externalLinks: $externalLinks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, title, description, category,
      requiredSkills, relatedCourses, externalLinks);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareerData &&
          other.code == this.code &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.requiredSkills == this.requiredSkills &&
          other.relatedCourses == this.relatedCourses &&
          other.externalLinks == this.externalLinks);
}

class CareersCompanion extends UpdateCompanion<CareerData> {
  final Value<String> code;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<List<String>> requiredSkills;
  final Value<List<String>> relatedCourses;
  final Value<Map<String, String>> externalLinks;
  final Value<int> rowid;
  const CareersCompanion({
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.requiredSkills = const Value.absent(),
    this.relatedCourses = const Value.absent(),
    this.externalLinks = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareersCompanion.insert({
    required String code,
    required String title,
    required String description,
    required String category,
    required List<String> requiredSkills,
    required List<String> relatedCourses,
    required Map<String, String> externalLinks,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        title = Value(title),
        description = Value(description),
        category = Value(category),
        requiredSkills = Value(requiredSkills),
        relatedCourses = Value(relatedCourses),
        externalLinks = Value(externalLinks);
  static Insertable<CareerData> custom({
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? requiredSkills,
    Expression<String>? relatedCourses,
    Expression<String>? externalLinks,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (requiredSkills != null) 'required_skills': requiredSkills,
      if (relatedCourses != null) 'related_courses': relatedCourses,
      if (externalLinks != null) 'external_links': externalLinks,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareersCompanion copyWith(
      {Value<String>? code,
      Value<String>? title,
      Value<String>? description,
      Value<String>? category,
      Value<List<String>>? requiredSkills,
      Value<List<String>>? relatedCourses,
      Value<Map<String, String>>? externalLinks,
      Value<int>? rowid}) {
    return CareersCompanion(
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      relatedCourses: relatedCourses ?? this.relatedCourses,
      externalLinks: externalLinks ?? this.externalLinks,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (requiredSkills.present) {
      map['required_skills'] = Variable<String>(
          $CareersTable.$converterrequiredSkills.toSql(requiredSkills.value));
    }
    if (relatedCourses.present) {
      map['related_courses'] = Variable<String>(
          $CareersTable.$converterrelatedCourses.toSql(relatedCourses.value));
    }
    if (externalLinks.present) {
      map['external_links'] = Variable<String>(
          $CareersTable.$converterexternalLinks.toSql(externalLinks.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareersCompanion(')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('requiredSkills: $requiredSkills, ')
          ..write('relatedCourses: $relatedCourses, ')
          ..write('externalLinks: $externalLinks, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstitutionsTable extends Institutions
    with TableInfo<$InstitutionsTable, InstitutionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstitutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contactInfoMeta =
      const VerificationMeta('contactInfo');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      contactInfo = GeneratedColumn<String>('contact_info', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $InstitutionsTable.$convertercontactInfo);
  static const VerificationMeta _coursesMeta =
      const VerificationMeta('courses');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> courses =
      GeneratedColumn<String>('courses', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($InstitutionsTable.$convertercourses);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, website, location, contactInfo, courses];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'institutions';
  @override
  VerificationContext validateIntegrity(Insertable<InstitutionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    } else if (isInserting) {
      context.missing(_websiteMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    context.handle(_contactInfoMeta, const VerificationResult.success());
    context.handle(_coursesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstitutionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstitutionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      contactInfo: $InstitutionsTable.$convertercontactInfo.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}contact_info'])!),
      courses: $InstitutionsTable.$convertercourses.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}courses'])!),
    );
  }

  @override
  $InstitutionsTable createAlias(String alias) {
    return $InstitutionsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $convertercontactInfo =
      const MapConverter<String, String>();
  static TypeConverter<List<String>, String> $convertercourses =
      const ListConverter<String>();
}

class InstitutionData extends DataClass implements Insertable<InstitutionData> {
  final String id;
  final String name;
  final String type;
  final String website;
  final String location;
  final Map<String, String> contactInfo;
  final List<String> courses;
  const InstitutionData(
      {required this.id,
      required this.name,
      required this.type,
      required this.website,
      required this.location,
      required this.contactInfo,
      required this.courses});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['website'] = Variable<String>(website);
    map['location'] = Variable<String>(location);
    {
      map['contact_info'] = Variable<String>(
          $InstitutionsTable.$convertercontactInfo.toSql(contactInfo));
    }
    {
      map['courses'] =
          Variable<String>($InstitutionsTable.$convertercourses.toSql(courses));
    }
    return map;
  }

  InstitutionsCompanion toCompanion(bool nullToAbsent) {
    return InstitutionsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      website: Value(website),
      location: Value(location),
      contactInfo: Value(contactInfo),
      courses: Value(courses),
    );
  }

  factory InstitutionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstitutionData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      website: serializer.fromJson<String>(json['website']),
      location: serializer.fromJson<String>(json['location']),
      contactInfo:
          serializer.fromJson<Map<String, String>>(json['contactInfo']),
      courses: serializer.fromJson<List<String>>(json['courses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'website': serializer.toJson<String>(website),
      'location': serializer.toJson<String>(location),
      'contactInfo': serializer.toJson<Map<String, String>>(contactInfo),
      'courses': serializer.toJson<List<String>>(courses),
    };
  }

  InstitutionData copyWith(
          {String? id,
          String? name,
          String? type,
          String? website,
          String? location,
          Map<String, String>? contactInfo,
          List<String>? courses}) =>
      InstitutionData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        website: website ?? this.website,
        location: location ?? this.location,
        contactInfo: contactInfo ?? this.contactInfo,
        courses: courses ?? this.courses,
      );
  InstitutionData copyWithCompanion(InstitutionsCompanion data) {
    return InstitutionData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      website: data.website.present ? data.website.value : this.website,
      location: data.location.present ? data.location.value : this.location,
      contactInfo:
          data.contactInfo.present ? data.contactInfo.value : this.contactInfo,
      courses: data.courses.present ? data.courses.value : this.courses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstitutionData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('website: $website, ')
          ..write('location: $location, ')
          ..write('contactInfo: $contactInfo, ')
          ..write('courses: $courses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, website, location, contactInfo, courses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstitutionData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.website == this.website &&
          other.location == this.location &&
          other.contactInfo == this.contactInfo &&
          other.courses == this.courses);
}

class InstitutionsCompanion extends UpdateCompanion<InstitutionData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> website;
  final Value<String> location;
  final Value<Map<String, String>> contactInfo;
  final Value<List<String>> courses;
  final Value<int> rowid;
  const InstitutionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.website = const Value.absent(),
    this.location = const Value.absent(),
    this.contactInfo = const Value.absent(),
    this.courses = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstitutionsCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String website,
    required String location,
    required Map<String, String> contactInfo,
    required List<String> courses,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        website = Value(website),
        location = Value(location),
        contactInfo = Value(contactInfo),
        courses = Value(courses);
  static Insertable<InstitutionData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? website,
    Expression<String>? location,
    Expression<String>? contactInfo,
    Expression<String>? courses,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (website != null) 'website': website,
      if (location != null) 'location': location,
      if (contactInfo != null) 'contact_info': contactInfo,
      if (courses != null) 'courses': courses,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstitutionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String>? website,
      Value<String>? location,
      Value<Map<String, String>>? contactInfo,
      Value<List<String>>? courses,
      Value<int>? rowid}) {
    return InstitutionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      website: website ?? this.website,
      location: location ?? this.location,
      contactInfo: contactInfo ?? this.contactInfo,
      courses: courses ?? this.courses,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (contactInfo.present) {
      map['contact_info'] = Variable<String>(
          $InstitutionsTable.$convertercontactInfo.toSql(contactInfo.value));
    }
    if (courses.present) {
      map['courses'] = Variable<String>(
          $InstitutionsTable.$convertercourses.toSql(courses.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstitutionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('website: $website, ')
          ..write('location: $location, ')
          ..write('contactInfo: $contactInfo, ')
          ..write('courses: $courses, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $StreamsTable streams = $StreamsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $CareersTable careers = $CareersTable(this);
  late final $InstitutionsTable institutions = $InstitutionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, streams, courses, careers, institutions];
}

typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  required String id,
  required String name,
  required String email,
  Value<String?> contact,
  Value<String?> school,
  required String district,
  required String password,
  required Map<String, String> olResults,
  required Map<String, String> alResults,
  Value<String?> stream,
  Value<double?> zScore,
  required List<String> interests,
  required List<String> skills,
  required List<String> strengths,
  required Map<String, Map<String, dynamic>> predictions,
  Value<int> rowid,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> email,
  Value<String?> contact,
  Value<String?> school,
  Value<String> district,
  Value<String> password,
  Value<Map<String, String>> olResults,
  Value<Map<String, String>> alResults,
  Value<String?> stream,
  Value<double?> zScore,
  Value<List<String>> interests,
  Value<List<String>> skills,
  Value<List<String>> strengths,
  Value<Map<String, Map<String, dynamic>>> predictions,
  Value<int> rowid,
});

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contact => $composableBuilder(
      column: $table.contact, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get school => $composableBuilder(
      column: $table.school, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get district => $composableBuilder(
      column: $table.district, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get olResults => $composableBuilder(
          column: $table.olResults,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get alResults => $composableBuilder(
          column: $table.alResults,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get stream => $composableBuilder(
      column: $table.stream, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get zScore => $composableBuilder(
      column: $table.zScore, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get interests => $composableBuilder(
          column: $table.interests,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get skills => $composableBuilder(
          column: $table.skills,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get strengths => $composableBuilder(
          column: $table.strengths,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Map<String, Map<String, dynamic>>,
          Map<String, Map<String, dynamic>>, String>
      get predictions => $composableBuilder(
          column: $table.predictions,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contact => $composableBuilder(
      column: $table.contact, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get school => $composableBuilder(
      column: $table.school, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get district => $composableBuilder(
      column: $table.district, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get olResults => $composableBuilder(
      column: $table.olResults, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alResults => $composableBuilder(
      column: $table.alResults, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stream => $composableBuilder(
      column: $table.stream, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get zScore => $composableBuilder(
      column: $table.zScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interests => $composableBuilder(
      column: $table.interests, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skills => $composableBuilder(
      column: $table.skills, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get strengths => $composableBuilder(
      column: $table.strengths, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get predictions => $composableBuilder(
      column: $table.predictions, builder: (column) => ColumnOrderings(column));
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get contact =>
      $composableBuilder(column: $table.contact, builder: (column) => column);

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String> get olResults =>
      $composableBuilder(column: $table.olResults, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String> get alResults =>
      $composableBuilder(column: $table.alResults, builder: (column) => column);

  GeneratedColumn<String> get stream =>
      $composableBuilder(column: $table.stream, builder: (column) => column);

  GeneratedColumn<double> get zScore =>
      $composableBuilder(column: $table.zScore, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get interests =>
      $composableBuilder(column: $table.interests, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get skills =>
      $composableBuilder(column: $table.skills, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get strengths =>
      $composableBuilder(column: $table.strengths, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, Map<String, dynamic>>, String>
      get predictions => $composableBuilder(
          column: $table.predictions, builder: (column) => column);
}

class $$StudentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentsTable,
    StudentData,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (StudentData, BaseReferences<_$AppDatabase, $StudentsTable, StudentData>),
    StudentData,
    PrefetchHooks Function()> {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> contact = const Value.absent(),
            Value<String?> school = const Value.absent(),
            Value<String> district = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<Map<String, String>> olResults = const Value.absent(),
            Value<Map<String, String>> alResults = const Value.absent(),
            Value<String?> stream = const Value.absent(),
            Value<double?> zScore = const Value.absent(),
            Value<List<String>> interests = const Value.absent(),
            Value<List<String>> skills = const Value.absent(),
            Value<List<String>> strengths = const Value.absent(),
            Value<Map<String, Map<String, dynamic>>> predictions =
                const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            name: name,
            email: email,
            contact: contact,
            school: school,
            district: district,
            password: password,
            olResults: olResults,
            alResults: alResults,
            stream: stream,
            zScore: zScore,
            interests: interests,
            skills: skills,
            strengths: strengths,
            predictions: predictions,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String email,
            Value<String?> contact = const Value.absent(),
            Value<String?> school = const Value.absent(),
            required String district,
            required String password,
            required Map<String, String> olResults,
            required Map<String, String> alResults,
            Value<String?> stream = const Value.absent(),
            Value<double?> zScore = const Value.absent(),
            required List<String> interests,
            required List<String> skills,
            required List<String> strengths,
            required Map<String, Map<String, dynamic>> predictions,
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentsCompanion.insert(
            id: id,
            name: name,
            email: email,
            contact: contact,
            school: school,
            district: district,
            password: password,
            olResults: olResults,
            alResults: alResults,
            stream: stream,
            zScore: zScore,
            interests: interests,
            skills: skills,
            strengths: strengths,
            predictions: predictions,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StudentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentsTable,
    StudentData,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (StudentData, BaseReferences<_$AppDatabase, $StudentsTable, StudentData>),
    StudentData,
    PrefetchHooks Function()>;
typedef $$StreamsTableCreateCompanionBuilder = StreamsCompanion Function({
  required String id,
  required String name,
  required String description,
  required List<String> requiredOLSubjects,
  required Map<String, String> minimumOLGrades,
  required Map<String, String> possibleCourses,
  required List<String> relatedCareers,
  Value<int> rowid,
});
typedef $$StreamsTableUpdateCompanionBuilder = StreamsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<List<String>> requiredOLSubjects,
  Value<Map<String, String>> minimumOLGrades,
  Value<Map<String, String>> possibleCourses,
  Value<List<String>> relatedCareers,
  Value<int> rowid,
});

final class $$StreamsTableReferences
    extends BaseReferences<_$AppDatabase, $StreamsTable, StreamData> {
  $$StreamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CoursesTable, List<CourseData>> _coursesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.courses,
          aliasName: $_aliasNameGenerator(db.streams.id, db.courses.streamId));

  $$CoursesTableProcessedTableManager get coursesRefs {
    final manager = $$CoursesTableTableManager($_db, $_db.courses)
        .filter((f) => f.streamId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_coursesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StreamsTableFilterComposer
    extends Composer<_$AppDatabase, $StreamsTable> {
  $$StreamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get requiredOLSubjects => $composableBuilder(
          column: $table.requiredOLSubjects,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get minimumOLGrades => $composableBuilder(
          column: $table.minimumOLGrades,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get possibleCourses => $composableBuilder(
          column: $table.possibleCourses,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get relatedCareers => $composableBuilder(
          column: $table.relatedCareers,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> coursesRefs(
      Expression<bool> Function($$CoursesTableFilterComposer f) f) {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.courses,
        getReferencedColumn: (t) => t.streamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CoursesTableFilterComposer(
              $db: $db,
              $table: $db.courses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StreamsTableOrderingComposer
    extends Composer<_$AppDatabase, $StreamsTable> {
  $$StreamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requiredOLSubjects => $composableBuilder(
      column: $table.requiredOLSubjects,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get minimumOLGrades => $composableBuilder(
      column: $table.minimumOLGrades,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get possibleCourses => $composableBuilder(
      column: $table.possibleCourses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedCareers => $composableBuilder(
      column: $table.relatedCareers,
      builder: (column) => ColumnOrderings(column));
}

class $$StreamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StreamsTable> {
  $$StreamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String>
      get requiredOLSubjects => $composableBuilder(
          column: $table.requiredOLSubjects, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get minimumOLGrades => $composableBuilder(
          column: $table.minimumOLGrades, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get possibleCourses => $composableBuilder(
          column: $table.possibleCourses, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get relatedCareers =>
      $composableBuilder(
          column: $table.relatedCareers, builder: (column) => column);

  Expression<T> coursesRefs<T extends Object>(
      Expression<T> Function($$CoursesTableAnnotationComposer a) f) {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.courses,
        getReferencedColumn: (t) => t.streamId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CoursesTableAnnotationComposer(
              $db: $db,
              $table: $db.courses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StreamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StreamsTable,
    StreamData,
    $$StreamsTableFilterComposer,
    $$StreamsTableOrderingComposer,
    $$StreamsTableAnnotationComposer,
    $$StreamsTableCreateCompanionBuilder,
    $$StreamsTableUpdateCompanionBuilder,
    (StreamData, $$StreamsTableReferences),
    StreamData,
    PrefetchHooks Function({bool coursesRefs})> {
  $$StreamsTableTableManager(_$AppDatabase db, $StreamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StreamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StreamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StreamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<List<String>> requiredOLSubjects = const Value.absent(),
            Value<Map<String, String>> minimumOLGrades = const Value.absent(),
            Value<Map<String, String>> possibleCourses = const Value.absent(),
            Value<List<String>> relatedCareers = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StreamsCompanion(
            id: id,
            name: name,
            description: description,
            requiredOLSubjects: requiredOLSubjects,
            minimumOLGrades: minimumOLGrades,
            possibleCourses: possibleCourses,
            relatedCareers: relatedCareers,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            required List<String> requiredOLSubjects,
            required Map<String, String> minimumOLGrades,
            required Map<String, String> possibleCourses,
            required List<String> relatedCareers,
            Value<int> rowid = const Value.absent(),
          }) =>
              StreamsCompanion.insert(
            id: id,
            name: name,
            description: description,
            requiredOLSubjects: requiredOLSubjects,
            minimumOLGrades: minimumOLGrades,
            possibleCourses: possibleCourses,
            relatedCareers: relatedCareers,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StreamsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({coursesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (coursesRefs) db.courses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (coursesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$StreamsTableReferences._coursesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StreamsTableReferences(db, table, p0).coursesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.streamId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StreamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StreamsTable,
    StreamData,
    $$StreamsTableFilterComposer,
    $$StreamsTableOrderingComposer,
    $$StreamsTableAnnotationComposer,
    $$StreamsTableCreateCompanionBuilder,
    $$StreamsTableUpdateCompanionBuilder,
    (StreamData, $$StreamsTableReferences),
    StreamData,
    PrefetchHooks Function({bool coursesRefs})>;
typedef $$CoursesTableCreateCompanionBuilder = CoursesCompanion Function({
  required String id,
  required String name,
  required String description,
  required String duration,
  required String streamId,
  required Map<String, String> minimumALGrades,
  required double minimumZScore,
  required List<String> offeredByInstitutions,
  required List<String> relatedCareers,
  Value<int> rowid,
});
typedef $$CoursesTableUpdateCompanionBuilder = CoursesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<String> duration,
  Value<String> streamId,
  Value<Map<String, String>> minimumALGrades,
  Value<double> minimumZScore,
  Value<List<String>> offeredByInstitutions,
  Value<List<String>> relatedCareers,
  Value<int> rowid,
});

final class $$CoursesTableReferences
    extends BaseReferences<_$AppDatabase, $CoursesTable, CourseData> {
  $$CoursesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StreamsTable _streamIdTable(_$AppDatabase db) => db.streams
      .createAlias($_aliasNameGenerator(db.courses.streamId, db.streams.id));

  $$StreamsTableProcessedTableManager get streamId {
    final manager = $$StreamsTableTableManager($_db, $_db.streams)
        .filter((f) => f.id($_item.streamId));
    final item = $_typedResult.readTableOrNull(_streamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CoursesTableFilterComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get minimumALGrades => $composableBuilder(
          column: $table.minimumALGrades,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get minimumZScore => $composableBuilder(
      column: $table.minimumZScore, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get offeredByInstitutions => $composableBuilder(
          column: $table.offeredByInstitutions,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get relatedCareers => $composableBuilder(
          column: $table.relatedCareers,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$StreamsTableFilterComposer get streamId {
    final $$StreamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.streamId,
        referencedTable: $db.streams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StreamsTableFilterComposer(
              $db: $db,
              $table: $db.streams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get minimumALGrades => $composableBuilder(
      column: $table.minimumALGrades,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minimumZScore => $composableBuilder(
      column: $table.minimumZScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get offeredByInstitutions => $composableBuilder(
      column: $table.offeredByInstitutions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedCareers => $composableBuilder(
      column: $table.relatedCareers,
      builder: (column) => ColumnOrderings(column));

  $$StreamsTableOrderingComposer get streamId {
    final $$StreamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.streamId,
        referencedTable: $db.streams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StreamsTableOrderingComposer(
              $db: $db,
              $table: $db.streams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get minimumALGrades => $composableBuilder(
          column: $table.minimumALGrades, builder: (column) => column);

  GeneratedColumn<double> get minimumZScore => $composableBuilder(
      column: $table.minimumZScore, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String>
      get offeredByInstitutions => $composableBuilder(
          column: $table.offeredByInstitutions, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get relatedCareers =>
      $composableBuilder(
          column: $table.relatedCareers, builder: (column) => column);

  $$StreamsTableAnnotationComposer get streamId {
    final $$StreamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.streamId,
        referencedTable: $db.streams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StreamsTableAnnotationComposer(
              $db: $db,
              $table: $db.streams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CoursesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CoursesTable,
    CourseData,
    $$CoursesTableFilterComposer,
    $$CoursesTableOrderingComposer,
    $$CoursesTableAnnotationComposer,
    $$CoursesTableCreateCompanionBuilder,
    $$CoursesTableUpdateCompanionBuilder,
    (CourseData, $$CoursesTableReferences),
    CourseData,
    PrefetchHooks Function({bool streamId})> {
  $$CoursesTableTableManager(_$AppDatabase db, $CoursesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> duration = const Value.absent(),
            Value<String> streamId = const Value.absent(),
            Value<Map<String, String>> minimumALGrades = const Value.absent(),
            Value<double> minimumZScore = const Value.absent(),
            Value<List<String>> offeredByInstitutions = const Value.absent(),
            Value<List<String>> relatedCareers = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CoursesCompanion(
            id: id,
            name: name,
            description: description,
            duration: duration,
            streamId: streamId,
            minimumALGrades: minimumALGrades,
            minimumZScore: minimumZScore,
            offeredByInstitutions: offeredByInstitutions,
            relatedCareers: relatedCareers,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            required String duration,
            required String streamId,
            required Map<String, String> minimumALGrades,
            required double minimumZScore,
            required List<String> offeredByInstitutions,
            required List<String> relatedCareers,
            Value<int> rowid = const Value.absent(),
          }) =>
              CoursesCompanion.insert(
            id: id,
            name: name,
            description: description,
            duration: duration,
            streamId: streamId,
            minimumALGrades: minimumALGrades,
            minimumZScore: minimumZScore,
            offeredByInstitutions: offeredByInstitutions,
            relatedCareers: relatedCareers,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CoursesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({streamId = false}) {
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
                if (streamId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.streamId,
                    referencedTable:
                        $$CoursesTableReferences._streamIdTable(db),
                    referencedColumn:
                        $$CoursesTableReferences._streamIdTable(db).id,
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

typedef $$CoursesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CoursesTable,
    CourseData,
    $$CoursesTableFilterComposer,
    $$CoursesTableOrderingComposer,
    $$CoursesTableAnnotationComposer,
    $$CoursesTableCreateCompanionBuilder,
    $$CoursesTableUpdateCompanionBuilder,
    (CourseData, $$CoursesTableReferences),
    CourseData,
    PrefetchHooks Function({bool streamId})>;
typedef $$CareersTableCreateCompanionBuilder = CareersCompanion Function({
  required String code,
  required String title,
  required String description,
  required String category,
  required List<String> requiredSkills,
  required List<String> relatedCourses,
  required Map<String, String> externalLinks,
  Value<int> rowid,
});
typedef $$CareersTableUpdateCompanionBuilder = CareersCompanion Function({
  Value<String> code,
  Value<String> title,
  Value<String> description,
  Value<String> category,
  Value<List<String>> requiredSkills,
  Value<List<String>> relatedCourses,
  Value<Map<String, String>> externalLinks,
  Value<int> rowid,
});

class $$CareersTableFilterComposer
    extends Composer<_$AppDatabase, $CareersTable> {
  $$CareersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get requiredSkills => $composableBuilder(
          column: $table.requiredSkills,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get relatedCourses => $composableBuilder(
          column: $table.relatedCourses,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get externalLinks => $composableBuilder(
          column: $table.externalLinks,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$CareersTableOrderingComposer
    extends Composer<_$AppDatabase, $CareersTable> {
  $$CareersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requiredSkills => $composableBuilder(
      column: $table.requiredSkills,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedCourses => $composableBuilder(
      column: $table.relatedCourses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get externalLinks => $composableBuilder(
      column: $table.externalLinks,
      builder: (column) => ColumnOrderings(column));
}

class $$CareersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareersTable> {
  $$CareersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get requiredSkills =>
      $composableBuilder(
          column: $table.requiredSkills, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get relatedCourses =>
      $composableBuilder(
          column: $table.relatedCourses, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get externalLinks => $composableBuilder(
          column: $table.externalLinks, builder: (column) => column);
}

class $$CareersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CareersTable,
    CareerData,
    $$CareersTableFilterComposer,
    $$CareersTableOrderingComposer,
    $$CareersTableAnnotationComposer,
    $$CareersTableCreateCompanionBuilder,
    $$CareersTableUpdateCompanionBuilder,
    (CareerData, BaseReferences<_$AppDatabase, $CareersTable, CareerData>),
    CareerData,
    PrefetchHooks Function()> {
  $$CareersTableTableManager(_$AppDatabase db, $CareersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> code = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<List<String>> requiredSkills = const Value.absent(),
            Value<List<String>> relatedCourses = const Value.absent(),
            Value<Map<String, String>> externalLinks = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CareersCompanion(
            code: code,
            title: title,
            description: description,
            category: category,
            requiredSkills: requiredSkills,
            relatedCourses: relatedCourses,
            externalLinks: externalLinks,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String code,
            required String title,
            required String description,
            required String category,
            required List<String> requiredSkills,
            required List<String> relatedCourses,
            required Map<String, String> externalLinks,
            Value<int> rowid = const Value.absent(),
          }) =>
              CareersCompanion.insert(
            code: code,
            title: title,
            description: description,
            category: category,
            requiredSkills: requiredSkills,
            relatedCourses: relatedCourses,
            externalLinks: externalLinks,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CareersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CareersTable,
    CareerData,
    $$CareersTableFilterComposer,
    $$CareersTableOrderingComposer,
    $$CareersTableAnnotationComposer,
    $$CareersTableCreateCompanionBuilder,
    $$CareersTableUpdateCompanionBuilder,
    (CareerData, BaseReferences<_$AppDatabase, $CareersTable, CareerData>),
    CareerData,
    PrefetchHooks Function()>;
typedef $$InstitutionsTableCreateCompanionBuilder = InstitutionsCompanion
    Function({
  required String id,
  required String name,
  required String type,
  required String website,
  required String location,
  required Map<String, String> contactInfo,
  required List<String> courses,
  Value<int> rowid,
});
typedef $$InstitutionsTableUpdateCompanionBuilder = InstitutionsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<String> website,
  Value<String> location,
  Value<Map<String, String>> contactInfo,
  Value<List<String>> courses,
  Value<int> rowid,
});

class $$InstitutionsTableFilterComposer
    extends Composer<_$AppDatabase, $InstitutionsTable> {
  $$InstitutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get contactInfo => $composableBuilder(
          column: $table.contactInfo,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get courses => $composableBuilder(
          column: $table.courses,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$InstitutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InstitutionsTable> {
  $$InstitutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contactInfo => $composableBuilder(
      column: $table.contactInfo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get courses => $composableBuilder(
      column: $table.courses, builder: (column) => ColumnOrderings(column));
}

class $$InstitutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstitutionsTable> {
  $$InstitutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get contactInfo => $composableBuilder(
          column: $table.contactInfo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get courses =>
      $composableBuilder(column: $table.courses, builder: (column) => column);
}

class $$InstitutionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InstitutionsTable,
    InstitutionData,
    $$InstitutionsTableFilterComposer,
    $$InstitutionsTableOrderingComposer,
    $$InstitutionsTableAnnotationComposer,
    $$InstitutionsTableCreateCompanionBuilder,
    $$InstitutionsTableUpdateCompanionBuilder,
    (
      InstitutionData,
      BaseReferences<_$AppDatabase, $InstitutionsTable, InstitutionData>
    ),
    InstitutionData,
    PrefetchHooks Function()> {
  $$InstitutionsTableTableManager(_$AppDatabase db, $InstitutionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstitutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstitutionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstitutionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> website = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<Map<String, String>> contactInfo = const Value.absent(),
            Value<List<String>> courses = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InstitutionsCompanion(
            id: id,
            name: name,
            type: type,
            website: website,
            location: location,
            contactInfo: contactInfo,
            courses: courses,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            required String website,
            required String location,
            required Map<String, String> contactInfo,
            required List<String> courses,
            Value<int> rowid = const Value.absent(),
          }) =>
              InstitutionsCompanion.insert(
            id: id,
            name: name,
            type: type,
            website: website,
            location: location,
            contactInfo: contactInfo,
            courses: courses,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InstitutionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InstitutionsTable,
    InstitutionData,
    $$InstitutionsTableFilterComposer,
    $$InstitutionsTableOrderingComposer,
    $$InstitutionsTableAnnotationComposer,
    $$InstitutionsTableCreateCompanionBuilder,
    $$InstitutionsTableUpdateCompanionBuilder,
    (
      InstitutionData,
      BaseReferences<_$AppDatabase, $InstitutionsTable, InstitutionData>
    ),
    InstitutionData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$StreamsTableTableManager get streams =>
      $$StreamsTableTableManager(_db, _db.streams);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$CareersTableTableManager get careers =>
      $$CareersTableTableManager(_db, _db.careers);
  $$InstitutionsTableTableManager get institutions =>
      $$InstitutionsTableTableManager(_db, _db.institutions);
}
