// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginObjectTearOff {
  const _$LoginObjectTearOff();

  _LoginObject call(String userName, String password) {
    return _LoginObject(
      userName,
      password,
    );
  }
}

/// @nodoc
const $LoginObject = _$LoginObjectTearOff();

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res>;
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res> implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  final LoginObject _value;
  // ignore: unused_field
  final $Res Function(LoginObject) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$LoginObjectCopyWith(
          _LoginObject value, $Res Function(_LoginObject) then) =
      __$LoginObjectCopyWithImpl<$Res>;
  @override
  $Res call({String userName, String password});
}

/// @nodoc
class __$LoginObjectCopyWithImpl<$Res> extends _$LoginObjectCopyWithImpl<$Res>
    implements _$LoginObjectCopyWith<$Res> {
  __$LoginObjectCopyWithImpl(
      _LoginObject _value, $Res Function(_LoginObject) _then)
      : super(_value, (v) => _then(v as _LoginObject));

  @override
  _LoginObject get _value => super._value as _LoginObject;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_LoginObject(
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginObject &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$LoginObjectCopyWith<_LoginObject> get copyWith =>
      __$LoginObjectCopyWithImpl<_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(String userName, String password) = _$_LoginObject;

  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginObjectCopyWith<_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$RegisterObjectTearOff {
  const _$RegisterObjectTearOff();

  _RegisterObject call(String userName, String password, bool value) {
    return _RegisterObject(
      userName,
      password,
      value,
    );
  }
}

/// @nodoc
const $RegisterObject = _$RegisterObjectTearOff();

/// @nodoc
mixin _$RegisterObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res>;
  $Res call({String userName, String password, bool value});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  final RegisterObject _value;
  // ignore: unused_field
  final $Res Function(RegisterObject) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$RegisterObjectCopyWith(
          _RegisterObject value, $Res Function(_RegisterObject) then) =
      __$RegisterObjectCopyWithImpl<$Res>;
  @override
  $Res call({String userName, String password, bool value});
}

/// @nodoc
class __$RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res>
    implements _$RegisterObjectCopyWith<$Res> {
  __$RegisterObjectCopyWithImpl(
      _RegisterObject _value, $Res Function(_RegisterObject) _then)
      : super(_value, (v) => _then(v as _RegisterObject));

  @override
  _RegisterObject get _value => super._value as _RegisterObject;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
    Object? value = freezed,
  }) {
    return _then(_RegisterObject(
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  _$_RegisterObject(this.userName, this.password, this.value);

  @override
  final String userName;
  @override
  final String password;
  @override
  final bool value;

  @override
  String toString() {
    return 'RegisterObject(userName: $userName, password: $password, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RegisterObject &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$RegisterObjectCopyWith<_RegisterObject> get copyWith =>
      __$RegisterObjectCopyWithImpl<_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(String userName, String password, bool value) =
      _$_RegisterObject;

  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  bool get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RegisterObjectCopyWith<_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$SecretObjectTearOff {
  const _$SecretObjectTearOff();

  _SecretObject call(String title, String text, String language) {
    return _SecretObject(
      title,
      text,
      language,
    );
  }
}

/// @nodoc
const $SecretObject = _$SecretObjectTearOff();

/// @nodoc
mixin _$SecretObject {
  String get title => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SecretObjectCopyWith<SecretObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretObjectCopyWith<$Res> {
  factory $SecretObjectCopyWith(
          SecretObject value, $Res Function(SecretObject) then) =
      _$SecretObjectCopyWithImpl<$Res>;
  $Res call({String title, String text, String language});
}

/// @nodoc
class _$SecretObjectCopyWithImpl<$Res> implements $SecretObjectCopyWith<$Res> {
  _$SecretObjectCopyWithImpl(this._value, this._then);

  final SecretObject _value;
  // ignore: unused_field
  final $Res Function(SecretObject) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? text = freezed,
    Object? language = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$SecretObjectCopyWith<$Res>
    implements $SecretObjectCopyWith<$Res> {
  factory _$SecretObjectCopyWith(
          _SecretObject value, $Res Function(_SecretObject) then) =
      __$SecretObjectCopyWithImpl<$Res>;
  @override
  $Res call({String title, String text, String language});
}

/// @nodoc
class __$SecretObjectCopyWithImpl<$Res> extends _$SecretObjectCopyWithImpl<$Res>
    implements _$SecretObjectCopyWith<$Res> {
  __$SecretObjectCopyWithImpl(
      _SecretObject _value, $Res Function(_SecretObject) _then)
      : super(_value, (v) => _then(v as _SecretObject));

  @override
  _SecretObject get _value => super._value as _SecretObject;

  @override
  $Res call({
    Object? title = freezed,
    Object? text = freezed,
    Object? language = freezed,
  }) {
    return _then(_SecretObject(
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SecretObject implements _SecretObject {
  _$_SecretObject(this.title, this.text, this.language);

  @override
  final String title;
  @override
  final String text;
  @override
  final String language;

  @override
  String toString() {
    return 'SecretObject(title: $title, text: $text, language: $language)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SecretObject &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(language);

  @JsonKey(ignore: true)
  @override
  _$SecretObjectCopyWith<_SecretObject> get copyWith =>
      __$SecretObjectCopyWithImpl<_SecretObject>(this, _$identity);
}

abstract class _SecretObject implements SecretObject {
  factory _SecretObject(String title, String text, String language) =
      _$_SecretObject;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get language => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SecretObjectCopyWith<_SecretObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CommentAddObjectTearOff {
  const _$CommentAddObjectTearOff();

  _CommentAddObject call(int secretId, String data) {
    return _CommentAddObject(
      secretId,
      data,
    );
  }
}

/// @nodoc
const $CommentAddObject = _$CommentAddObjectTearOff();

/// @nodoc
mixin _$CommentAddObject {
  int get secretId => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentAddObjectCopyWith<CommentAddObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentAddObjectCopyWith<$Res> {
  factory $CommentAddObjectCopyWith(
          CommentAddObject value, $Res Function(CommentAddObject) then) =
      _$CommentAddObjectCopyWithImpl<$Res>;
  $Res call({int secretId, String data});
}

/// @nodoc
class _$CommentAddObjectCopyWithImpl<$Res>
    implements $CommentAddObjectCopyWith<$Res> {
  _$CommentAddObjectCopyWithImpl(this._value, this._then);

  final CommentAddObject _value;
  // ignore: unused_field
  final $Res Function(CommentAddObject) _then;

  @override
  $Res call({
    Object? secretId = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      secretId: secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CommentAddObjectCopyWith<$Res>
    implements $CommentAddObjectCopyWith<$Res> {
  factory _$CommentAddObjectCopyWith(
          _CommentAddObject value, $Res Function(_CommentAddObject) then) =
      __$CommentAddObjectCopyWithImpl<$Res>;
  @override
  $Res call({int secretId, String data});
}

/// @nodoc
class __$CommentAddObjectCopyWithImpl<$Res>
    extends _$CommentAddObjectCopyWithImpl<$Res>
    implements _$CommentAddObjectCopyWith<$Res> {
  __$CommentAddObjectCopyWithImpl(
      _CommentAddObject _value, $Res Function(_CommentAddObject) _then)
      : super(_value, (v) => _then(v as _CommentAddObject));

  @override
  _CommentAddObject get _value => super._value as _CommentAddObject;

  @override
  $Res call({
    Object? secretId = freezed,
    Object? data = freezed,
  }) {
    return _then(_CommentAddObject(
      secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CommentAddObject implements _CommentAddObject {
  _$_CommentAddObject(this.secretId, this.data);

  @override
  final int secretId;
  @override
  final String data;

  @override
  String toString() {
    return 'CommentAddObject(secretId: $secretId, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommentAddObject &&
            (identical(other.secretId, secretId) ||
                const DeepCollectionEquality()
                    .equals(other.secretId, secretId)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(secretId) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$CommentAddObjectCopyWith<_CommentAddObject> get copyWith =>
      __$CommentAddObjectCopyWithImpl<_CommentAddObject>(this, _$identity);
}

abstract class _CommentAddObject implements CommentAddObject {
  factory _CommentAddObject(int secretId, String data) = _$_CommentAddObject;

  @override
  int get secretId => throw _privateConstructorUsedError;
  @override
  String get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommentAddObjectCopyWith<_CommentAddObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ProfileDeleteObjectTearOff {
  const _$ProfileDeleteObjectTearOff();

  _ProfileDeleteObject call(int secretId) {
    return _ProfileDeleteObject(
      secretId,
    );
  }
}

/// @nodoc
const $ProfileDeleteObject = _$ProfileDeleteObjectTearOff();

/// @nodoc
mixin _$ProfileDeleteObject {
  int get secretId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileDeleteObjectCopyWith<ProfileDeleteObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileDeleteObjectCopyWith<$Res> {
  factory $ProfileDeleteObjectCopyWith(
          ProfileDeleteObject value, $Res Function(ProfileDeleteObject) then) =
      _$ProfileDeleteObjectCopyWithImpl<$Res>;
  $Res call({int secretId});
}

/// @nodoc
class _$ProfileDeleteObjectCopyWithImpl<$Res>
    implements $ProfileDeleteObjectCopyWith<$Res> {
  _$ProfileDeleteObjectCopyWithImpl(this._value, this._then);

  final ProfileDeleteObject _value;
  // ignore: unused_field
  final $Res Function(ProfileDeleteObject) _then;

  @override
  $Res call({
    Object? secretId = freezed,
  }) {
    return _then(_value.copyWith(
      secretId: secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ProfileDeleteObjectCopyWith<$Res>
    implements $ProfileDeleteObjectCopyWith<$Res> {
  factory _$ProfileDeleteObjectCopyWith(_ProfileDeleteObject value,
          $Res Function(_ProfileDeleteObject) then) =
      __$ProfileDeleteObjectCopyWithImpl<$Res>;
  @override
  $Res call({int secretId});
}

/// @nodoc
class __$ProfileDeleteObjectCopyWithImpl<$Res>
    extends _$ProfileDeleteObjectCopyWithImpl<$Res>
    implements _$ProfileDeleteObjectCopyWith<$Res> {
  __$ProfileDeleteObjectCopyWithImpl(
      _ProfileDeleteObject _value, $Res Function(_ProfileDeleteObject) _then)
      : super(_value, (v) => _then(v as _ProfileDeleteObject));

  @override
  _ProfileDeleteObject get _value => super._value as _ProfileDeleteObject;

  @override
  $Res call({
    Object? secretId = freezed,
  }) {
    return _then(_ProfileDeleteObject(
      secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ProfileDeleteObject implements _ProfileDeleteObject {
  _$_ProfileDeleteObject(this.secretId);

  @override
  final int secretId;

  @override
  String toString() {
    return 'ProfileDeleteObject(secretId: $secretId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProfileDeleteObject &&
            (identical(other.secretId, secretId) ||
                const DeepCollectionEquality()
                    .equals(other.secretId, secretId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(secretId);

  @JsonKey(ignore: true)
  @override
  _$ProfileDeleteObjectCopyWith<_ProfileDeleteObject> get copyWith =>
      __$ProfileDeleteObjectCopyWithImpl<_ProfileDeleteObject>(
          this, _$identity);
}

abstract class _ProfileDeleteObject implements ProfileDeleteObject {
  factory _ProfileDeleteObject(int secretId) = _$_ProfileDeleteObject;

  @override
  int get secretId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProfileDeleteObjectCopyWith<_ProfileDeleteObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$HomePostObjectTearOff {
  const _$HomePostObjectTearOff();

  _HomePostObject call(String language, int page) {
    return _HomePostObject(
      language,
      page,
    );
  }
}

/// @nodoc
const $HomePostObject = _$HomePostObjectTearOff();

/// @nodoc
mixin _$HomePostObject {
  String get language => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePostObjectCopyWith<HomePostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePostObjectCopyWith<$Res> {
  factory $HomePostObjectCopyWith(
          HomePostObject value, $Res Function(HomePostObject) then) =
      _$HomePostObjectCopyWithImpl<$Res>;
  $Res call({String language, int page});
}

/// @nodoc
class _$HomePostObjectCopyWithImpl<$Res>
    implements $HomePostObjectCopyWith<$Res> {
  _$HomePostObjectCopyWithImpl(this._value, this._then);

  final HomePostObject _value;
  // ignore: unused_field
  final $Res Function(HomePostObject) _then;

  @override
  $Res call({
    Object? language = freezed,
    Object? page = freezed,
  }) {
    return _then(_value.copyWith(
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$HomePostObjectCopyWith<$Res>
    implements $HomePostObjectCopyWith<$Res> {
  factory _$HomePostObjectCopyWith(
          _HomePostObject value, $Res Function(_HomePostObject) then) =
      __$HomePostObjectCopyWithImpl<$Res>;
  @override
  $Res call({String language, int page});
}

/// @nodoc
class __$HomePostObjectCopyWithImpl<$Res>
    extends _$HomePostObjectCopyWithImpl<$Res>
    implements _$HomePostObjectCopyWith<$Res> {
  __$HomePostObjectCopyWithImpl(
      _HomePostObject _value, $Res Function(_HomePostObject) _then)
      : super(_value, (v) => _then(v as _HomePostObject));

  @override
  _HomePostObject get _value => super._value as _HomePostObject;

  @override
  $Res call({
    Object? language = freezed,
    Object? page = freezed,
  }) {
    return _then(_HomePostObject(
      language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_HomePostObject implements _HomePostObject {
  _$_HomePostObject(this.language, this.page);

  @override
  final String language;
  @override
  final int page;

  @override
  String toString() {
    return 'HomePostObject(language: $language, page: $page)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HomePostObject &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(page);

  @JsonKey(ignore: true)
  @override
  _$HomePostObjectCopyWith<_HomePostObject> get copyWith =>
      __$HomePostObjectCopyWithImpl<_HomePostObject>(this, _$identity);
}

abstract class _HomePostObject implements HomePostObject {
  factory _HomePostObject(String language, int page) = _$_HomePostObject;

  @override
  String get language => throw _privateConstructorUsedError;
  @override
  int get page => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HomePostObjectCopyWith<_HomePostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ProfilePostObjectTearOff {
  const _$ProfilePostObjectTearOff();

  _ProfilePostObject call(int page) {
    return _ProfilePostObject(
      page,
    );
  }
}

/// @nodoc
const $ProfilePostObject = _$ProfilePostObjectTearOff();

/// @nodoc
mixin _$ProfilePostObject {
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfilePostObjectCopyWith<ProfilePostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfilePostObjectCopyWith<$Res> {
  factory $ProfilePostObjectCopyWith(
          ProfilePostObject value, $Res Function(ProfilePostObject) then) =
      _$ProfilePostObjectCopyWithImpl<$Res>;
  $Res call({int page});
}

/// @nodoc
class _$ProfilePostObjectCopyWithImpl<$Res>
    implements $ProfilePostObjectCopyWith<$Res> {
  _$ProfilePostObjectCopyWithImpl(this._value, this._then);

  final ProfilePostObject _value;
  // ignore: unused_field
  final $Res Function(ProfilePostObject) _then;

  @override
  $Res call({
    Object? page = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ProfilePostObjectCopyWith<$Res>
    implements $ProfilePostObjectCopyWith<$Res> {
  factory _$ProfilePostObjectCopyWith(
          _ProfilePostObject value, $Res Function(_ProfilePostObject) then) =
      __$ProfilePostObjectCopyWithImpl<$Res>;
  @override
  $Res call({int page});
}

/// @nodoc
class __$ProfilePostObjectCopyWithImpl<$Res>
    extends _$ProfilePostObjectCopyWithImpl<$Res>
    implements _$ProfilePostObjectCopyWith<$Res> {
  __$ProfilePostObjectCopyWithImpl(
      _ProfilePostObject _value, $Res Function(_ProfilePostObject) _then)
      : super(_value, (v) => _then(v as _ProfilePostObject));

  @override
  _ProfilePostObject get _value => super._value as _ProfilePostObject;

  @override
  $Res call({
    Object? page = freezed,
  }) {
    return _then(_ProfilePostObject(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ProfilePostObject implements _ProfilePostObject {
  _$_ProfilePostObject(this.page);

  @override
  final int page;

  @override
  String toString() {
    return 'ProfilePostObject(page: $page)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProfilePostObject &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(page);

  @JsonKey(ignore: true)
  @override
  _$ProfilePostObjectCopyWith<_ProfilePostObject> get copyWith =>
      __$ProfilePostObjectCopyWithImpl<_ProfilePostObject>(this, _$identity);
}

abstract class _ProfilePostObject implements ProfilePostObject {
  factory _ProfilePostObject(int page) = _$_ProfilePostObject;

  @override
  int get page => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProfilePostObjectCopyWith<_ProfilePostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CommentPostObjectTearOff {
  const _$CommentPostObjectTearOff();

  _CommentPostObject call(int secretId, String language, int page) {
    return _CommentPostObject(
      secretId,
      language,
      page,
    );
  }
}

/// @nodoc
const $CommentPostObject = _$CommentPostObjectTearOff();

/// @nodoc
mixin _$CommentPostObject {
  int get secretId => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentPostObjectCopyWith<CommentPostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentPostObjectCopyWith<$Res> {
  factory $CommentPostObjectCopyWith(
          CommentPostObject value, $Res Function(CommentPostObject) then) =
      _$CommentPostObjectCopyWithImpl<$Res>;
  $Res call({int secretId, String language, int page});
}

/// @nodoc
class _$CommentPostObjectCopyWithImpl<$Res>
    implements $CommentPostObjectCopyWith<$Res> {
  _$CommentPostObjectCopyWithImpl(this._value, this._then);

  final CommentPostObject _value;
  // ignore: unused_field
  final $Res Function(CommentPostObject) _then;

  @override
  $Res call({
    Object? secretId = freezed,
    Object? language = freezed,
    Object? page = freezed,
  }) {
    return _then(_value.copyWith(
      secretId: secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CommentPostObjectCopyWith<$Res>
    implements $CommentPostObjectCopyWith<$Res> {
  factory _$CommentPostObjectCopyWith(
          _CommentPostObject value, $Res Function(_CommentPostObject) then) =
      __$CommentPostObjectCopyWithImpl<$Res>;
  @override
  $Res call({int secretId, String language, int page});
}

/// @nodoc
class __$CommentPostObjectCopyWithImpl<$Res>
    extends _$CommentPostObjectCopyWithImpl<$Res>
    implements _$CommentPostObjectCopyWith<$Res> {
  __$CommentPostObjectCopyWithImpl(
      _CommentPostObject _value, $Res Function(_CommentPostObject) _then)
      : super(_value, (v) => _then(v as _CommentPostObject));

  @override
  _CommentPostObject get _value => super._value as _CommentPostObject;

  @override
  $Res call({
    Object? secretId = freezed,
    Object? language = freezed,
    Object? page = freezed,
  }) {
    return _then(_CommentPostObject(
      secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
      language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CommentPostObject implements _CommentPostObject {
  _$_CommentPostObject(this.secretId, this.language, this.page);

  @override
  final int secretId;
  @override
  final String language;
  @override
  final int page;

  @override
  String toString() {
    return 'CommentPostObject(secretId: $secretId, language: $language, page: $page)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommentPostObject &&
            (identical(other.secretId, secretId) ||
                const DeepCollectionEquality()
                    .equals(other.secretId, secretId)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(secretId) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(page);

  @JsonKey(ignore: true)
  @override
  _$CommentPostObjectCopyWith<_CommentPostObject> get copyWith =>
      __$CommentPostObjectCopyWithImpl<_CommentPostObject>(this, _$identity);
}

abstract class _CommentPostObject implements CommentPostObject {
  factory _CommentPostObject(int secretId, String language, int page) =
      _$_CommentPostObject;

  @override
  int get secretId => throw _privateConstructorUsedError;
  @override
  String get language => throw _privateConstructorUsedError;
  @override
  int get page => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommentPostObjectCopyWith<_CommentPostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CommentDeleteObjectTearOff {
  const _$CommentDeleteObjectTearOff();

  _CommentDeleteObject call(int secretId, int commentId) {
    return _CommentDeleteObject(
      secretId,
      commentId,
    );
  }
}

/// @nodoc
const $CommentDeleteObject = _$CommentDeleteObjectTearOff();

/// @nodoc
mixin _$CommentDeleteObject {
  int get secretId => throw _privateConstructorUsedError;
  int get commentId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentDeleteObjectCopyWith<CommentDeleteObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentDeleteObjectCopyWith<$Res> {
  factory $CommentDeleteObjectCopyWith(
          CommentDeleteObject value, $Res Function(CommentDeleteObject) then) =
      _$CommentDeleteObjectCopyWithImpl<$Res>;
  $Res call({int secretId, int commentId});
}

/// @nodoc
class _$CommentDeleteObjectCopyWithImpl<$Res>
    implements $CommentDeleteObjectCopyWith<$Res> {
  _$CommentDeleteObjectCopyWithImpl(this._value, this._then);

  final CommentDeleteObject _value;
  // ignore: unused_field
  final $Res Function(CommentDeleteObject) _then;

  @override
  $Res call({
    Object? secretId = freezed,
    Object? commentId = freezed,
  }) {
    return _then(_value.copyWith(
      secretId: secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
      commentId: commentId == freezed
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CommentDeleteObjectCopyWith<$Res>
    implements $CommentDeleteObjectCopyWith<$Res> {
  factory _$CommentDeleteObjectCopyWith(_CommentDeleteObject value,
          $Res Function(_CommentDeleteObject) then) =
      __$CommentDeleteObjectCopyWithImpl<$Res>;
  @override
  $Res call({int secretId, int commentId});
}

/// @nodoc
class __$CommentDeleteObjectCopyWithImpl<$Res>
    extends _$CommentDeleteObjectCopyWithImpl<$Res>
    implements _$CommentDeleteObjectCopyWith<$Res> {
  __$CommentDeleteObjectCopyWithImpl(
      _CommentDeleteObject _value, $Res Function(_CommentDeleteObject) _then)
      : super(_value, (v) => _then(v as _CommentDeleteObject));

  @override
  _CommentDeleteObject get _value => super._value as _CommentDeleteObject;

  @override
  $Res call({
    Object? secretId = freezed,
    Object? commentId = freezed,
  }) {
    return _then(_CommentDeleteObject(
      secretId == freezed
          ? _value.secretId
          : secretId // ignore: cast_nullable_to_non_nullable
              as int,
      commentId == freezed
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CommentDeleteObject implements _CommentDeleteObject {
  _$_CommentDeleteObject(this.secretId, this.commentId);

  @override
  final int secretId;
  @override
  final int commentId;

  @override
  String toString() {
    return 'CommentDeleteObject(secretId: $secretId, commentId: $commentId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommentDeleteObject &&
            (identical(other.secretId, secretId) ||
                const DeepCollectionEquality()
                    .equals(other.secretId, secretId)) &&
            (identical(other.commentId, commentId) ||
                const DeepCollectionEquality()
                    .equals(other.commentId, commentId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(secretId) ^
      const DeepCollectionEquality().hash(commentId);

  @JsonKey(ignore: true)
  @override
  _$CommentDeleteObjectCopyWith<_CommentDeleteObject> get copyWith =>
      __$CommentDeleteObjectCopyWithImpl<_CommentDeleteObject>(
          this, _$identity);
}

abstract class _CommentDeleteObject implements CommentDeleteObject {
  factory _CommentDeleteObject(int secretId, int commentId) =
      _$_CommentDeleteObject;

  @override
  int get secretId => throw _privateConstructorUsedError;
  @override
  int get commentId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommentDeleteObjectCopyWith<_CommentDeleteObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CommentSecretObjectTearOff {
  const _$CommentSecretObjectTearOff();

  _CommentSecretObject call(int id, String title, String content, String date,
      String sign, int viewCount, String language, int commentCount) {
    return _CommentSecretObject(
      id,
      title,
      content,
      date,
      sign,
      viewCount,
      language,
      commentCount,
    );
  }
}

/// @nodoc
const $CommentSecretObject = _$CommentSecretObjectTearOff();

/// @nodoc
mixin _$CommentSecretObject {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get sign => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentSecretObjectCopyWith<CommentSecretObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentSecretObjectCopyWith<$Res> {
  factory $CommentSecretObjectCopyWith(
          CommentSecretObject value, $Res Function(CommentSecretObject) then) =
      _$CommentSecretObjectCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      String content,
      String date,
      String sign,
      int viewCount,
      String language,
      int commentCount});
}

/// @nodoc
class _$CommentSecretObjectCopyWithImpl<$Res>
    implements $CommentSecretObjectCopyWith<$Res> {
  _$CommentSecretObjectCopyWithImpl(this._value, this._then);

  final CommentSecretObject _value;
  // ignore: unused_field
  final $Res Function(CommentSecretObject) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? date = freezed,
    Object? sign = freezed,
    Object? viewCount = freezed,
    Object? language = freezed,
    Object? commentCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      sign: sign == freezed
          ? _value.sign
          : sign // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount: viewCount == freezed
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      commentCount: commentCount == freezed
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CommentSecretObjectCopyWith<$Res>
    implements $CommentSecretObjectCopyWith<$Res> {
  factory _$CommentSecretObjectCopyWith(_CommentSecretObject value,
          $Res Function(_CommentSecretObject) then) =
      __$CommentSecretObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      String content,
      String date,
      String sign,
      int viewCount,
      String language,
      int commentCount});
}

/// @nodoc
class __$CommentSecretObjectCopyWithImpl<$Res>
    extends _$CommentSecretObjectCopyWithImpl<$Res>
    implements _$CommentSecretObjectCopyWith<$Res> {
  __$CommentSecretObjectCopyWithImpl(
      _CommentSecretObject _value, $Res Function(_CommentSecretObject) _then)
      : super(_value, (v) => _then(v as _CommentSecretObject));

  @override
  _CommentSecretObject get _value => super._value as _CommentSecretObject;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? date = freezed,
    Object? sign = freezed,
    Object? viewCount = freezed,
    Object? language = freezed,
    Object? commentCount = freezed,
  }) {
    return _then(_CommentSecretObject(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      sign == freezed
          ? _value.sign
          : sign // ignore: cast_nullable_to_non_nullable
              as String,
      viewCount == freezed
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      commentCount == freezed
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CommentSecretObject implements _CommentSecretObject {
  _$_CommentSecretObject(this.id, this.title, this.content, this.date,
      this.sign, this.viewCount, this.language, this.commentCount);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String date;
  @override
  final String sign;
  @override
  final int viewCount;
  @override
  final String language;
  @override
  final int commentCount;

  @override
  String toString() {
    return 'CommentSecretObject(id: $id, title: $title, content: $content, date: $date, sign: $sign, viewCount: $viewCount, language: $language, commentCount: $commentCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommentSecretObject &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.sign, sign) ||
                const DeepCollectionEquality().equals(other.sign, sign)) &&
            (identical(other.viewCount, viewCount) ||
                const DeepCollectionEquality()
                    .equals(other.viewCount, viewCount)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.commentCount, commentCount) ||
                const DeepCollectionEquality()
                    .equals(other.commentCount, commentCount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(sign) ^
      const DeepCollectionEquality().hash(viewCount) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(commentCount);

  @JsonKey(ignore: true)
  @override
  _$CommentSecretObjectCopyWith<_CommentSecretObject> get copyWith =>
      __$CommentSecretObjectCopyWithImpl<_CommentSecretObject>(
          this, _$identity);
}

abstract class _CommentSecretObject implements CommentSecretObject {
  factory _CommentSecretObject(
      int id,
      String title,
      String content,
      String date,
      String sign,
      int viewCount,
      String language,
      int commentCount) = _$_CommentSecretObject;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get content => throw _privateConstructorUsedError;
  @override
  String get date => throw _privateConstructorUsedError;
  @override
  String get sign => throw _privateConstructorUsedError;
  @override
  int get viewCount => throw _privateConstructorUsedError;
  @override
  String get language => throw _privateConstructorUsedError;
  @override
  int get commentCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommentSecretObjectCopyWith<_CommentSecretObject> get copyWith =>
      throw _privateConstructorUsedError;
}
