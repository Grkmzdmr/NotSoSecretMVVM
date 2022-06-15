
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get IsConnected;
}

class NetworkInfoImplementer implements NetworkInfo {
  
  InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImplementer(this._internetConnectionChecker);

  @override
  Future<bool> get IsConnected => _internetConnectionChecker.hasConnection;
}
