import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/data/data_source/local_data_source.dart';
import 'package:not_so_secret/data/data_source/remote_data_source.dart';
import 'package:not_so_secret/data/network/app_api.dart';
import 'package:not_so_secret/data/network/dio_factory.dart';
import 'package:not_so_secret/data/network/network_info.dart';
import 'package:not_so_secret/data/repository/repository_impl.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:not_so_secret/domain/repository/repository.dart';
import 'package:not_so_secret/domain/usecase/comment_usecase.dart';
import 'package:not_so_secret/domain/usecase/home_usecase.dart';
import 'package:not_so_secret/domain/usecase/login_usecase.dart';
import 'package:not_so_secret/domain/usecase/profile_usecase.dart';
import 'package:not_so_secret/domain/usecase/register_usecase.dart';
import 'package:not_so_secret/domain/usecase/secret_usecase.dart';
import 'package:not_so_secret/presentation/add_secret/add_secret_viewmodel.dart';
import 'package:not_so_secret/presentation/comment/comment_viewmodel.dart';
import 'package:not_so_secret/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:not_so_secret/presentation/main/home/home_viewmodel.dart';
import 'package:not_so_secret/presentation/main/profile/profile_viewmodel.dart';
import 'package:not_so_secret/presentation/register/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(DataConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));
  //local data source
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer());

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));

  //initLoginModule();
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initSendSecretModule() {
  if (!GetIt.I.isRegistered<SecretUseCase>()) {
    instance.registerFactory<SecretUseCase>(() => SecretUseCase(instance()));
    instance.registerFactory<AddSecretViewModel>(
        () => AddSecretViewModel(instance()));
  }
}

initCommentModule() {
  if (!GetIt.I.isRegistered<CommentUseCase>()) {
    instance.registerFactory<CommentUseCase>(() => CommentUseCase(instance()));
    instance
        .registerFactory<CommentViewModel>(() => CommentViewModel(instance()));
  }
}

initProfileModule() {
  if (!GetIt.I.isRegistered<ProfileUseCase>()) {
    instance.registerFactory<ProfileUseCase>(() => ProfileUseCase(instance()));
    instance
        .registerFactory<ProfileViewModel>(() => ProfileViewModel(instance()));
  }
}

resetAllModule() {
  instance.reset(dispose: false);
  initAppModule();
  initHomeModule();
  initLoginModule();
  initRegisterModule();
  initSendSecretModule();
  initProfileModule();
}

resetHomeModule() {
  instance.reset(dispose: false);
  initAppModule();
  initHomeModule();
  initCommentModule();
}
