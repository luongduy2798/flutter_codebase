import 'package:flutter/material.dart';
import '../components/show_dialog.dart';
import 'api/response_error.dart';

catchError(BuildContext context, error, {Function? callback}) {
  ResponseError? e = ResponseError.bindResponseError(error);
  showAppDialog(context,
      message: e != null && e.message != null ? e.message : 'Error!',
      callback: () {
    // callback();
  });
}
