import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWidget {
  Widget text({
    required String data,
    bool? softWrap,
    TextStyle? style,
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    softWrap ??= true;
    style ??= GoogleFonts.poppins();
    textAlign ??= TextAlign.center;

    return Text(
      data,
      softWrap: softWrap,
      style: style.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  Widget button({
    required Function() onPressed,
    required Widget child,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    Color? shadowColor,
    BorderRadiusGeometry? borderRadius,
    Color? borderColor,
    bool? enabled,
  }) {
    backgroundColor ??= Colors.white;
    disabledBackgroundColor ??= Colors.grey;
    borderRadius ??= BorderRadius.zero;
    borderColor ??= backgroundColor;
    enabled ??= true;

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        elevation: elevation,
        padding: padding,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        side: BorderSide(color: borderColor),
      ),
      child: child,
    );
  }

  Widget input({
    TextEditingController? controller,
    Color? cursorColor,
    bool? enabled,
    String? initialValue,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    bool? obscureText,
    Function(String)? onChanged,
    Function(String)? onFieldSubmitted,
    bool? readOnly,
    String? Function(String?)? validator,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    Color? fillColor,
    InputBorder? focusedBorder,
    bool? isDense,
    Widget? label,
    Widget? prefix,
    Widget? suffix,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    cursorColor ??= Colors.black;
    obscureText ??= false;
    readOnly ??= false;
    isDense ??= true;

    InputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    );

    disabledBorder ??= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey),
    );

    enabledBorder ??= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    );

    focusedBorder ??= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black, width: 2),
    );

    return TextFormField(
      controller: controller,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        border: defaultBorder,
        contentPadding: contentPadding,
        disabledBorder: disabledBorder,
        enabledBorder: enabledBorder,
        fillColor: fillColor,
        filled: fillColor != null,
        focusedBorder: focusedBorder,
        isDense: isDense,
        label: label,
        prefix: prefix,
        suffix: suffix,
      ),
      enabled: enabled,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly,
      style: GoogleFonts.poppins(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      validator: validator,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

MainWidget get w => MainWidget();
