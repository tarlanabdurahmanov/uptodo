import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import 'font_manager.dart';

Text defaultText(
  String text, {
  double? fontSize,
  double? height,
  FontWeight? fontWeight,
  Color? color,
  int? maxLines,
  TextOverflow? overflow,
  TextAlign? textAlign,
  TextStyle? style,
}) {
  return Text(
    text,
    style: style ??
        TextStyle(
          fontSize: fontSize ?? FontSize.details,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? AppColors.black,
          height: height,
          // fontFamily: "UberMoveText",
        ),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
  );
}

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

TextStyle getBlackStyle(
        {double fontSize = FontSize.title, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.black, color);

TextStyle getBoldStyle(
        {double fontSize = FontSize.subTitle, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.bold, color);

TextStyle getMediumStyle(
        {double fontSize = FontSize.body, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.medium, color);

TextStyle getRegularStyle(
        {double fontSize = FontSize.details, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.regular, color);

TextStyle getLightStyle(
        {double fontSize = FontSize.light, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.light, color);
