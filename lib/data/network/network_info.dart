import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get IsConnected;
}

class NetworkInfoImplementer implements NetworkInfo {
  DataConnectionChecker _dataConnectionChecker;
  
  NetworkInfoImplementer(this._dataConnectionChecker);
  
  @override
  Future<bool> get IsConnected => _dataConnectionChecker.hasConnection;
}
