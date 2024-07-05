// ignore_for_file: prefer_final_fields, deprecated_member_use, prefer_const_constructors

import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/languages.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProgressLoader {
  BuildContext? _context, _dismissingContext;
  bool _barrierDismissible = true, _showLogs = false, _isShowing = false;

  final double _dialogElevation = 8.0, _borderRadius = 8.0;
  final Color _backgroundColor = colors.whitecolor;
  final Curve _insetAnimCurve = Curves.easeInOut;

  ProgressLoader(BuildContext buildContext, {required bool isDismissible}) {
    _context = buildContext;
    _barrierDismissible = isDismissible;
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext!).pop();
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } else {
        if (_showLogs) debugPrint('ProgressDialog already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  Future<bool> show() async {
    try {
      if (!_isShowing) {
        showDialog<dynamic>(
          context: _context!,
          barrierDismissible: _barrierDismissible,
          builder: (BuildContext context) {
            _dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: Dialog(
                  insetPadding: EdgeInsets.only(left: 50, right: 70),
                  backgroundColor: _backgroundColor,
                  insetAnimationCurve: _insetAnimCurve,
                  insetAnimationDuration: const Duration(milliseconds: 100),
                  elevation: _dialogElevation,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  child: const LoaderBody()),
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(const Duration(milliseconds: 200));
        if (_showLogs) debugPrint('ProgressDialog shown');
        _isShowing = true;
        return true;
      } else {
        if (_showLogs) debugPrint("ProgressDialog already shown/showing");
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }
}

class LoaderBody extends StatelessWidget {
  const LoaderBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CupertinoActivityIndicator(
                radius: 1.4.h,
                color: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.blackcolor
                    : colors.blackcolor,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Text(
                translate('Loading...'),
                style: TextStyle(fontSize: 16, color: colors.blackcolor),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
