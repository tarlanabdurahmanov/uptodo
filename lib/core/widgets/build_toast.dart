import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/core/enums/app_enums.dart';

Future<bool?> buildToast({required String msg, required ToastType type}) =>
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 16,
      textColor: AppColors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor:
          type == ToastType.success ? AppColors.black : AppColors.error,
    );
