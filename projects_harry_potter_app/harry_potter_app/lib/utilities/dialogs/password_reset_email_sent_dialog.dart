import 'package:flutter/widgets.dart';

import 'generic_dialog.dart';

Future<void> showPasswordResentSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have now sent you a password reset link. Please check your email for more information.',
    optionsBuilder: /*() =>*/ {
      'OK': null,
    },
  );
}
