import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternet() async {
  var connectivity = await (Connectivity().checkConnectivity());
  if (connectivity == ConnectivityResult.mobile ||
      connectivity == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
