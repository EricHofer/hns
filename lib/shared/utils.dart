import 'package:flutter/material.dart';

void msgBox(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Message'),
        content: Text(message),
        actions: [TextButton(child: Text('OK'), onPressed: () => Navigator.of(context).pop())],
      );
    },
  );
}

enum DialogResult { ok, no, cancel }

Future<DialogResult> showOkCancelDialog(BuildContext context, String title, String message) {
  return showDialog<DialogResult>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(DialogResult.cancel)),
          TextButton(child: Text('OK'), onPressed: () => Navigator.of(context).pop(DialogResult.ok)),
        ],
      );
    },
  ).then((result) => result ?? DialogResult.cancel); // Default to cancel if dismissed
}

Future<DialogResult> show3AnswerDialog(
  BuildContext context,
  String title,
  String message, [
  String nmButtonOK = "OK",
  String nmButtonNo = "No",
  String nmButtonCancel = 'Cancel',
]) {
  return showDialog<DialogResult>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(child: Text(nmButtonOK), onPressed: () => Navigator.of(context).pop(DialogResult.ok)),
          TextButton(child: Text(nmButtonNo), onPressed: () => Navigator.of(context).pop(DialogResult.no)),
          TextButton(child: Text(nmButtonCancel), onPressed: () => Navigator.of(context).pop(DialogResult.cancel)),
        ],
      );
    },
  ).then((result) => result ?? DialogResult.cancel); // Default to cancel if dismissed
}
