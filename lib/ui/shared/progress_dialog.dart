import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog showProgressDialog(BuildContext context, text){

  final ProgressDialog progressDialog = ProgressDialog(context, 
  type: ProgressDialogType.Normal, 
  isDismissible: false, showLogs: false);

  progressDialog.style(
    message: text,
  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );

  return progressDialog;

}