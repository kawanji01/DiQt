import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// テスト環境に優しいGoogle Fontsユーティリティ
class SafeGoogleFonts {
  /// テスト環境またはGoogle Fontsが無効な場合に安全にフォントを取得
  static TextStyle mPlusRounded1c({
    required BuildContext context,
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    final baseStyle = textStyle ?? Theme.of(context).textTheme.bodyMedium!;
    
    // テスト環境またはGoogle Fontsが無効な場合は通常のフォントを使用
    if (kDebugMode || !GoogleFonts.config.allowRuntimeFetching) {
      return baseStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
    }
    
    try {
      return GoogleFonts.mPlusRounded1c(
        textStyle: baseStyle,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
    } catch (e) {
      // Google Fontsの読み込みに失敗した場合は通常のフォントを使用
      return baseStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
    }
  }
  
  /// テスト環境に対応したNoto Sansテキストテーマ
  static TextTheme notoSansTextTheme(TextTheme? baseTheme) {
    // テスト環境またはGoogle Fontsが無効な場合は元のテーマを返す
    if (kDebugMode || !GoogleFonts.config.allowRuntimeFetching) {
      return baseTheme ?? const TextTheme();
    }
    
    try {
      return GoogleFonts.notoSansTextTheme(baseTheme);
    } catch (e) {
      // Google Fontsの読み込みに失敗した場合は元のテーマを返す
      return baseTheme ?? const TextTheme();
    }
  }
}