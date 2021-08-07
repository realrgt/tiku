import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_status.dart';

class NetworkStatusImpl implements INetworkStatus {
  final InternetConnectionChecker connectionChecker;

  NetworkStatusImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
