// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
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
  late final GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>,
      String> predictions = GeneratedColumn<String>(
          'predictions', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true)
      .withConverter<List<Map<String, dynamic>>>(
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
  VerificationContext validateIntegrity(Insertable<Student> instance,
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
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
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
  static TypeConverter<List<Map<String, dynamic>>, String>
      $converterpredictions = const ListConverter<Map<String, dynamic>>();
}

class Student extends DataClass implements Insertable<Student> {
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
  final List<Map<String, dynamic>> predictions;
  const Student(
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

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
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
      predictions:
          serializer.fromJson<List<Map<String, dynamic>>>(json['predictions']),
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
      'predictions': serializer.toJson<List<Map<String, dynamic>>>(predictions),
    };
  }

  Student copyWith(
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
          List<Map<String, dynamic>>? predictions}) =>
      Student(
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
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
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
    return (StringBuffer('Student(')
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
      (other is Student &&
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

class StudentsCompanion extends UpdateCompanion<Student> {
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
  final Value<List<Map<String, dynamic>>> predictions;
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
    required List<Map<String, dynamic>> predictions,
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
  static Insertable<Student> custom({
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
      Value<List<Map<String, dynamic>>>? predictions,
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

class $StudyStreamsTable extends StudyStreams
    with TableInfo<$StudyStreamsTable, StudyStream> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyStreamsTable(this.attachedDatabase, [this._alias]);
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
              $StudyStreamsTable.$converterrequiredOLSubjects);
  static const VerificationMeta _minimumOLGradesMeta =
      const VerificationMeta('minimumOLGrades');
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      minimumOLGrades = GeneratedColumn<String>(
              'minimum_o_l_grades', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $StudyStreamsTable.$converterminimumOLGrades);
  static const VerificationMeta _possibleCoursesMeta =
      const VerificationMeta('possibleCourses');
  @override
  late final GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>,
      String> possibleCourses = GeneratedColumn<String>(
          'possible_courses', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true)
      .withConverter<List<Map<String, dynamic>>>(
          $StudyStreamsTable.$converterpossibleCourses);
  static const VerificationMeta _relatedCareersMeta =
      const VerificationMeta('relatedCareers');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      relatedCareers = GeneratedColumn<String>(
              'related_careers', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $StudyStreamsTable.$converterrelatedCareers);
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
  static const String $name = 'study_streams';
  @override
  VerificationContext validateIntegrity(Insertable<StudyStream> instance,
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
  StudyStream map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyStream(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      requiredOLSubjects: $StudyStreamsTable.$converterrequiredOLSubjects
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}required_o_l_subjects'])!),
      minimumOLGrades: $StudyStreamsTable.$converterminimumOLGrades.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}minimum_o_l_grades'])!),
      possibleCourses: $StudyStreamsTable.$converterpossibleCourses.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}possible_courses'])!),
      relatedCareers: $StudyStreamsTable.$converterrelatedCareers.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}related_careers'])!),
    );
  }

  @override
  $StudyStreamsTable createAlias(String alias) {
    return $StudyStreamsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterrequiredOLSubjects =
      const ListConverter<String>();
  static TypeConverter<Map<String, String>, String> $converterminimumOLGrades =
      const MapConverter<String, String>();
  static TypeConverter<List<Map<String, dynamic>>, String>
      $converterpossibleCourses = const ListConverter<Map<String, dynamic>>();
  static TypeConverter<List<String>, String> $converterrelatedCareers =
      const ListConverter<String>();
}

class StudyStream extends DataClass implements Insertable<StudyStream> {
  final String id;
  final String name;
  final String description;
  final List<String> requiredOLSubjects;
  final Map<String, String> minimumOLGrades;
  final List<Map<String, dynamic>> possibleCourses;
  final List<String> relatedCareers;
  const StudyStream(
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
      map['required_o_l_subjects'] = Variable<String>($StudyStreamsTable
          .$converterrequiredOLSubjects
          .toSql(requiredOLSubjects));
    }
    {
      map['minimum_o_l_grades'] = Variable<String>(
          $StudyStreamsTable.$converterminimumOLGrades.toSql(minimumOLGrades));
    }
    {
      map['possible_courses'] = Variable<String>(
          $StudyStreamsTable.$converterpossibleCourses.toSql(possibleCourses));
    }
    {
      map['related_careers'] = Variable<String>(
          $StudyStreamsTable.$converterrelatedCareers.toSql(relatedCareers));
    }
    return map;
  }

  StudyStreamsCompanion toCompanion(bool nullToAbsent) {
    return StudyStreamsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      requiredOLSubjects: Value(requiredOLSubjects),
      minimumOLGrades: Value(minimumOLGrades),
      possibleCourses: Value(possibleCourses),
      relatedCareers: Value(relatedCareers),
    );
  }

  factory StudyStream.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyStream(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      requiredOLSubjects:
          serializer.fromJson<List<String>>(json['requiredOLSubjects']),
      minimumOLGrades:
          serializer.fromJson<Map<String, String>>(json['minimumOLGrades']),
      possibleCourses: serializer
          .fromJson<List<Map<String, dynamic>>>(json['possibleCourses']),
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
          serializer.toJson<List<Map<String, dynamic>>>(possibleCourses),
      'relatedCareers': serializer.toJson<List<String>>(relatedCareers),
    };
  }

  StudyStream copyWith(
          {String? id,
          String? name,
          String? description,
          List<String>? requiredOLSubjects,
          Map<String, String>? minimumOLGrades,
          List<Map<String, dynamic>>? possibleCourses,
          List<String>? relatedCareers}) =>
      StudyStream(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        requiredOLSubjects: requiredOLSubjects ?? this.requiredOLSubjects,
        minimumOLGrades: minimumOLGrades ?? this.minimumOLGrades,
        possibleCourses: possibleCourses ?? this.possibleCourses,
        relatedCareers: relatedCareers ?? this.relatedCareers,
      );
  StudyStream copyWithCompanion(StudyStreamsCompanion data) {
    return StudyStream(
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
    return (StringBuffer('StudyStream(')
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
      (other is StudyStream &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.requiredOLSubjects == this.requiredOLSubjects &&
          other.minimumOLGrades == this.minimumOLGrades &&
          other.possibleCourses == this.possibleCourses &&
          other.relatedCareers == this.relatedCareers);
}

class StudyStreamsCompanion extends UpdateCompanion<StudyStream> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<List<String>> requiredOLSubjects;
  final Value<Map<String, String>> minimumOLGrades;
  final Value<List<Map<String, dynamic>>> possibleCourses;
  final Value<List<String>> relatedCareers;
  final Value<int> rowid;
  const StudyStreamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.requiredOLSubjects = const Value.absent(),
    this.minimumOLGrades = const Value.absent(),
    this.possibleCourses = const Value.absent(),
    this.relatedCareers = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyStreamsCompanion.insert({
    required String id,
    required String name,
    required String description,
    required List<String> requiredOLSubjects,
    required Map<String, String> minimumOLGrades,
    required List<Map<String, dynamic>> possibleCourses,
    required List<String> relatedCareers,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        requiredOLSubjects = Value(requiredOLSubjects),
        minimumOLGrades = Value(minimumOLGrades),
        possibleCourses = Value(possibleCourses),
        relatedCareers = Value(relatedCareers);
  static Insertable<StudyStream> custom({
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

  StudyStreamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<List<String>>? requiredOLSubjects,
      Value<Map<String, String>>? minimumOLGrades,
      Value<List<Map<String, dynamic>>>? possibleCourses,
      Value<List<String>>? relatedCareers,
      Value<int>? rowid}) {
    return StudyStreamsCompanion(
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
      map['required_o_l_subjects'] = Variable<String>($StudyStreamsTable
          .$converterrequiredOLSubjects
          .toSql(requiredOLSubjects.value));
    }
    if (minimumOLGrades.present) {
      map['minimum_o_l_grades'] = Variable<String>($StudyStreamsTable
          .$converterminimumOLGrades
          .toSql(minimumOLGrades.value));
    }
    if (possibleCourses.present) {
      map['possible_courses'] = Variable<String>($StudyStreamsTable
          .$converterpossibleCourses
          .toSql(possibleCourses.value));
    }
    if (relatedCareers.present) {
      map['related_careers'] = Variable<String>($StudyStreamsTable
          .$converterrelatedCareers
          .toSql(relatedCareers.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyStreamsCompanion(')
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

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  VerificationContext validateIntegrity(Insertable<Course> instance,
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
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
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

class Course extends DataClass implements Insertable<Course> {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String streamId;
  final Map<String, String> minimumALGrades;
  final double minimumZScore;
  final List<String> offeredByInstitutions;
  final List<String> relatedCareers;
  const Course(
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

  factory Course.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
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

  Course copyWith(
          {String? id,
          String? name,
          String? description,
          String? duration,
          String? streamId,
          Map<String, String>? minimumALGrades,
          double? minimumZScore,
          List<String>? offeredByInstitutions,
          List<String>? relatedCareers}) =>
      Course(
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
  Course copyWithCompanion(CoursesCompanion data) {
    return Course(
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
    return (StringBuffer('Course(')
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
      (other is Course &&
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

class CoursesCompanion extends UpdateCompanion<Course> {
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
  static Insertable<Course> custom({
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $StudyStreamsTable studyStreams = $StudyStreamsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, studyStreams, courses];
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
  required List<Map<String, dynamic>> predictions,
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
  Value<List<Map<String, dynamic>>> predictions,
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

  ColumnWithTypeConverterFilters<List<Map<String, dynamic>>,
          List<Map<String, dynamic>>, String>
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

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
      get predictions => $composableBuilder(
          column: $table.predictions, builder: (column) => column);
}

class $$StudentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
    Student,
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
            Value<List<Map<String, dynamic>>> predictions =
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
            required List<Map<String, dynamic>> predictions,
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
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
    Student,
    PrefetchHooks Function()>;
typedef $$StudyStreamsTableCreateCompanionBuilder = StudyStreamsCompanion
    Function({
  required String id,
  required String name,
  required String description,
  required List<String> requiredOLSubjects,
  required Map<String, String> minimumOLGrades,
  required List<Map<String, dynamic>> possibleCourses,
  required List<String> relatedCareers,
  Value<int> rowid,
});
typedef $$StudyStreamsTableUpdateCompanionBuilder = StudyStreamsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<List<String>> requiredOLSubjects,
  Value<Map<String, String>> minimumOLGrades,
  Value<List<Map<String, dynamic>>> possibleCourses,
  Value<List<String>> relatedCareers,
  Value<int> rowid,
});

class $$StudyStreamsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyStreamsTable> {
  $$StudyStreamsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<List<Map<String, dynamic>>,
          List<Map<String, dynamic>>, String>
      get possibleCourses => $composableBuilder(
          column: $table.possibleCourses,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get relatedCareers => $composableBuilder(
          column: $table.relatedCareers,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$StudyStreamsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyStreamsTable> {
  $$StudyStreamsTableOrderingComposer({
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

class $$StudyStreamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyStreamsTable> {
  $$StudyStreamsTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<List<Map<String, dynamic>>, String>
      get possibleCourses => $composableBuilder(
          column: $table.possibleCourses, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get relatedCareers =>
      $composableBuilder(
          column: $table.relatedCareers, builder: (column) => column);
}

class $$StudyStreamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudyStreamsTable,
    StudyStream,
    $$StudyStreamsTableFilterComposer,
    $$StudyStreamsTableOrderingComposer,
    $$StudyStreamsTableAnnotationComposer,
    $$StudyStreamsTableCreateCompanionBuilder,
    $$StudyStreamsTableUpdateCompanionBuilder,
    (
      StudyStream,
      BaseReferences<_$AppDatabase, $StudyStreamsTable, StudyStream>
    ),
    StudyStream,
    PrefetchHooks Function()> {
  $$StudyStreamsTableTableManager(_$AppDatabase db, $StudyStreamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyStreamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyStreamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyStreamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<List<String>> requiredOLSubjects = const Value.absent(),
            Value<Map<String, String>> minimumOLGrades = const Value.absent(),
            Value<List<Map<String, dynamic>>> possibleCourses =
                const Value.absent(),
            Value<List<String>> relatedCareers = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudyStreamsCompanion(
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
            required List<Map<String, dynamic>> possibleCourses,
            required List<String> relatedCareers,
            Value<int> rowid = const Value.absent(),
          }) =>
              StudyStreamsCompanion.insert(
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StudyStreamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudyStreamsTable,
    StudyStream,
    $$StudyStreamsTableFilterComposer,
    $$StudyStreamsTableOrderingComposer,
    $$StudyStreamsTableAnnotationComposer,
    $$StudyStreamsTableCreateCompanionBuilder,
    $$StudyStreamsTableUpdateCompanionBuilder,
    (
      StudyStream,
      BaseReferences<_$AppDatabase, $StudyStreamsTable, StudyStream>
    ),
    StudyStream,
    PrefetchHooks Function()>;
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

  ColumnFilters<String> get streamId => $composableBuilder(
      column: $table.streamId, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get streamId => $composableBuilder(
      column: $table.streamId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get streamId =>
      $composableBuilder(column: $table.streamId, builder: (column) => column);

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
}

class $$CoursesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CoursesTable,
    Course,
    $$CoursesTableFilterComposer,
    $$CoursesTableOrderingComposer,
    $$CoursesTableAnnotationComposer,
    $$CoursesTableCreateCompanionBuilder,
    $$CoursesTableUpdateCompanionBuilder,
    (Course, BaseReferences<_$AppDatabase, $CoursesTable, Course>),
    Course,
    PrefetchHooks Function()> {
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CoursesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CoursesTable,
    Course,
    $$CoursesTableFilterComposer,
    $$CoursesTableOrderingComposer,
    $$CoursesTableAnnotationComposer,
    $$CoursesTableCreateCompanionBuilder,
    $$CoursesTableUpdateCompanionBuilder,
    (Course, BaseReferences<_$AppDatabase, $CoursesTable, Course>),
    Course,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$StudyStreamsTableTableManager get studyStreams =>
      $$StudyStreamsTableTableManager(_db, _db.studyStreams);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
}
