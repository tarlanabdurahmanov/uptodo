import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/theme/app_colors.dart';
import '../enums/app_enums.dart';

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
