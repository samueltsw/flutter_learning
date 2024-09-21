import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff2f6a43),
      surfaceTint: Color(0xff2f6a43),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb2f1c0),
      onPrimaryContainer: Color(0xff00210d),
      secondary: Color(0xff4f6353),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd2e8d3),
      onSecondaryContainer: Color(0xff0d1f12),
      tertiary: Color(0xff3a656f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbeeaf6),
      onTertiaryContainer: Color(0xff001f25),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff6fbf3),
      onBackground: Color(0xff181d18),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff181d18),
      surfaceVariant: Color(0xffdde5db),
      onSurfaceVariant: Color(0xff414941),
      outline: Color(0xff717971),
      outlineVariant: Color(0xffc1c9bf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inverseOnSurface: Color(0xffedf2ea),
      inversePrimary: Color(0xff97d5a5),
      primaryFixed: Color(0xffb2f1c0),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff97d5a5),
      onPrimaryFixedVariant: Color(0xff14512d),
      secondaryFixed: Color(0xffd2e8d3),
      onSecondaryFixed: Color(0xff0d1f12),
      secondaryFixedDim: Color(0xffb6ccb8),
      onSecondaryFixedVariant: Color(0xff384b3c),
      tertiaryFixed: Color(0xffbeeaf6),
      onTertiaryFixed: Color(0xff001f25),
      tertiaryFixedDim: Color(0xffa2ced9),
      onTertiaryFixedVariant: Color(0xff204d56),
      surfaceDim: Color(0xffd7dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ed),
      surfaceContainer: Color(0xffebefe8),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dc),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff0e4d29),
      surfaceTint: Color(0xff2f6a43),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff468158),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff344738),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff657a68),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1c4952),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff517b85),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff6fbf3),
      onBackground: Color(0xff181d18),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff181d18),
      surfaceVariant: Color(0xffdde5db),
      onSurfaceVariant: Color(0xff3d453e),
      outline: Color(0xff596159),
      outlineVariant: Color(0xff757d74),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inverseOnSurface: Color(0xffedf2ea),
      inversePrimary: Color(0xff97d5a5),
      primaryFixed: Color(0xff468158),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2d6741),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff657a68),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4d6150),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff517b85),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff37626c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ed),
      surfaceContainer: Color(0xffebefe8),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dc),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002911),
      surfaceTint: Color(0xff2f6a43),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0e4d29),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff142619),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff344738),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00262e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1c4952),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff6fbf3),
      onBackground: Color(0xff181d18),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdde5db),
      onSurfaceVariant: Color(0xff1e261f),
      outline: Color(0xff3d453e),
      outlineVariant: Color(0xff3d453e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffbcfbc9),
      primaryFixed: Color(0xff0e4d29),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003518),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff344738),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1f3123),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1c4952),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00323b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ed),
      surfaceContainer: Color(0xffebefe8),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff97d5a5),
      surfaceTint: Color(0xff97d5a5),
      onPrimary: Color(0xff00391b),
      primaryContainer: Color(0xff14512d),
      onPrimaryContainer: Color(0xffb2f1c0),
      secondary: Color(0xffb6ccb8),
      onSecondary: Color(0xff223526),
      secondaryContainer: Color(0xff384b3c),
      onSecondaryContainer: Color(0xffd2e8d3),
      tertiary: Color(0xffa2ced9),
      onTertiary: Color(0xff01363f),
      tertiaryContainer: Color(0xff204d56),
      onTertiaryContainer: Color(0xffbeeaf6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff101510),
      onBackground: Color(0xffdfe4dc),
      surface: Color(0xff101510),
      onSurface: Color(0xffdfe4dc),
      surfaceVariant: Color(0xff414941),
      onSurfaceVariant: Color(0xffc1c9bf),
      outline: Color(0xff8b938a),
      outlineVariant: Color(0xff414941),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      inverseOnSurface: Color(0xff2d322d),
      inversePrimary: Color(0xff2f6a43),
      primaryFixed: Color(0xffb2f1c0),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff97d5a5),
      onPrimaryFixedVariant: Color(0xff14512d),
      secondaryFixed: Color(0xffd2e8d3),
      onSecondaryFixed: Color(0xff0d1f12),
      secondaryFixedDim: Color(0xffb6ccb8),
      onSecondaryFixedVariant: Color(0xff384b3c),
      tertiaryFixed: Color(0xffbeeaf6),
      onTertiaryFixed: Color(0xff001f25),
      tertiaryFixedDim: Color(0xffa2ced9),
      onTertiaryFixedVariant: Color(0xff204d56),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff353a35),
      surfaceContainerLowest: Color(0xff0a0f0b),
      surfaceContainerLow: Color(0xff181d18),
      surfaceContainer: Color(0xff1c211c),
      surfaceContainerHigh: Color(0xff262b26),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9bd9a9),
      surfaceTint: Color(0xff97d5a5),
      onPrimary: Color(0xff001b0a),
      primaryContainer: Color(0xff629e72),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbbd0bc),
      onSecondary: Color(0xff081a0d),
      secondaryContainer: Color(0xff819684),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa6d2de),
      onTertiary: Color(0xff00191f),
      tertiaryContainer: Color(0xff6d97a2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101510),
      onBackground: Color(0xffdfe4dc),
      surface: Color(0xff101510),
      onSurface: Color(0xfff8fcf4),
      surfaceVariant: Color(0xff414941),
      onSurfaceVariant: Color(0xffc5cdc3),
      outline: Color(0xff9da59c),
      outlineVariant: Color(0xff7d857d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      inverseOnSurface: Color(0xff262b26),
      inversePrimary: Color(0xff16522e),
      primaryFixed: Color(0xffb2f1c0),
      onPrimaryFixed: Color(0xff001507),
      primaryFixedDim: Color(0xff97d5a5),
      onPrimaryFixedVariant: Color(0xff003f1f),
      secondaryFixed: Color(0xffd2e8d3),
      onSecondaryFixed: Color(0xff041509),
      secondaryFixedDim: Color(0xffb6ccb8),
      onSecondaryFixedVariant: Color(0xff283a2c),
      tertiaryFixed: Color(0xffbeeaf6),
      onTertiaryFixed: Color(0xff001419),
      tertiaryFixedDim: Color(0xffa2ced9),
      onTertiaryFixedVariant: Color(0xff0a3c45),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff353a35),
      surfaceContainerLowest: Color(0xff0a0f0b),
      surfaceContainerLow: Color(0xff181d18),
      surfaceContainer: Color(0xff1c211c),
      surfaceContainerHigh: Color(0xff262b26),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffefffee),
      surfaceTint: Color(0xff97d5a5),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9bd9a9),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffefffee),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbbd0bc),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff3fcff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa6d2de),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101510),
      onBackground: Color(0xffdfe4dc),
      surface: Color(0xff101510),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff414941),
      onSurfaceVariant: Color(0xfff5fdf2),
      outline: Color(0xffc5cdc3),
      outlineVariant: Color(0xffc5cdc3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003217),
      primaryFixed: Color(0xffb6f6c4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9bd9a9),
      onPrimaryFixedVariant: Color(0xff001b0a),
      secondaryFixed: Color(0xffd6edd8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbbd0bc),
      onSecondaryFixedVariant: Color(0xff081a0d),
      tertiaryFixed: Color(0xffc2eefa),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa6d2de),
      onTertiaryFixedVariant: Color(0xff00191f),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff353a35),
      surfaceContainerLowest: Color(0xff0a0f0b),
      surfaceContainerLow: Color(0xff181d18),
      surfaceContainer: Color(0xff1c211c),
      surfaceContainerHigh: Color(0xff262b26),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
