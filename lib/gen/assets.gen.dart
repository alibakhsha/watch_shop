/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/user.png
  AssetGenImage get user => const AssetGenImage('assets/png/user.png');

  /// File path: assets/png/watch.png
  AssetGenImage get watch => const AssetGenImage('assets/png/watch.png');

  /// List of all assets
  List<AssetGenImage> get values => [user, watch];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/61217.svg
  String get a61217 => 'assets/svg/61217.svg';

  /// File path: assets/svg/Group 226.svg
  String get group226 => 'assets/svg/Group 226.svg';

  /// File path: assets/svg/Group 244.svg
  String get group244 => 'assets/svg/Group 244.svg';

  /// File path: assets/svg/Group 245.svg
  String get group245 => 'assets/svg/Group 245.svg';

  /// File path: assets/svg/Group 246.svg
  String get group246 => 'assets/svg/Group 246.svg';

  /// File path: assets/svg/Group 255.svg
  String get group255 => 'assets/svg/Group 255.svg';

  /// File path: assets/svg/Group 256.svg
  String get group256 => 'assets/svg/Group 256.svg';

  /// File path: assets/svg/Group 257.svg
  String get group257 => 'assets/svg/Group 257.svg';

  /// File path: assets/svg/Vector.svg
  String get vector => 'assets/svg/Vector.svg';

  /// File path: assets/svg/cart.svg
  String get cart => 'assets/svg/cart.svg';

  /// File path: assets/svg/cart1.svg
  String get cart1 => 'assets/svg/cart1.svg';

  /// File path: assets/svg/delete.svg
  String get delete => 'assets/svg/delete.svg';

  /// File path: assets/svg/home-hashtag.svg
  String get homeHashtag => 'assets/svg/home-hashtag.svg';

  /// File path: assets/svg/home-hashtag1.svg
  String get homeHashtag1 => 'assets/svg/home-hashtag1.svg';

  /// File path: assets/svg/minus.svg
  String get minus => 'assets/svg/minus.svg';

  /// File path: assets/svg/plus.svg
  String get plus => 'assets/svg/plus.svg';

  /// File path: assets/svg/user.svg
  String get user => 'assets/svg/user.svg';

  /// File path: assets/svg/user1.svg
  String get user1 => 'assets/svg/user1.svg';

  /// File path: assets/svg/vuesax-linear-direct-left.svg
  String get vuesaxLinearDirectLeft =>
      'assets/svg/vuesax-linear-direct-left.svg';

  /// File path: assets/svg/vuesax-linear-location-add.svg
  String get vuesaxLinearLocationAdd =>
      'assets/svg/vuesax-linear-location-add.svg';

  /// File path: assets/svg/vuesax-linear-search-normal.svg
  String get vuesaxLinearSearchNormal =>
      'assets/svg/vuesax-linear-search-normal.svg';

  /// List of all assets
  List<String> get values => [
    a61217,
    group226,
    group244,
    group245,
    group246,
    group255,
    group256,
    group257,
    vector,
    cart,
    cart1,
    delete,
    homeHashtag,
    homeHashtag1,
    minus,
    plus,
    user,
    user1,
    vuesaxLinearDirectLeft,
    vuesaxLinearLocationAdd,
    vuesaxLinearSearchNormal,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
