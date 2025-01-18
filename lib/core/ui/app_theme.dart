import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    final Color primaryColor = context.colors.primary;
    return ThemeData(
      primarySwatch: Colors.blue,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        hourMinuteTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? Colors.white : Colors.black),
        hourMinuteColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? Colors.blue : Colors.grey.shade200),
        dialHandColor: primaryColor,
        dialBackgroundColor: Colors.blue.shade50,
        entryModeIconColor: primaryColor,
        helpTextStyle: TextStyle(
          color: primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            context.textStyles.textSemiBold.copyWith(color: context.colors.primary),
          ),
        ),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            context.textStyles.textSemiBold.copyWith(color: context.colors.primary),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: context.textStyles.textBold.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
