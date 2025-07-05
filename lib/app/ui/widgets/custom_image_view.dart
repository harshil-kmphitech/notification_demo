// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification_demo/app/utils/helpers/extensions/extensions.dart';

class CustomImageView extends StatelessWidget {
  const CustomImageView(
    this.imagePath, {
    super.key,
    this.fit,
    this.shape,
    this.width,
    this.color,
    this.onTap,
    this.height,
    this.margin,
    this.border,
    this.imageData,
    this.alignment,
    this.colorFilter,
    this.borderRadius,
    this.colorBlendMode,
  });

  final BoxFit? fit;
  final Color? color;
  final double? width;
  final double? height;
  final BoxShape? shape;
  final String imagePath;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final Alignment? alignment;
  final Uint8List? imageData;
  final ColorFilter? colorFilter;
  final BlendMode? colorBlendMode;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    if (alignment != null) {
      return Align(alignment: alignment!, child: _buildWidget());
    }

    return _buildWidget();
  }

  Widget _buildWidget() {
    var buildCircleImage = _buildImageWithBorder();
    if (onTap != null) {
      buildCircleImage = InkWell(onTap: onTap, child: buildCircleImage);
    }
    if (margin != null) {
      buildCircleImage = Padding(padding: margin ?? EdgeInsets.zero, child: buildCircleImage);
    }
    return buildCircleImage;
  }

  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(shape: shape ?? BoxShape.rectangle, border: border, borderRadius: borderRadius),
        child: _buildCircleImage(),
      );
    }
    return _buildCircleImage();
  }

  Widget _buildCircleImage() {
    if (shape != null) {
      return ClipOval(child: _buildRadiusCircleImage());
    }
    return _buildRadiusCircleImage();
  }

  Widget _buildRadiusCircleImage() {
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius ?? BorderRadius.zero, child: _buildImageView());
    }
    return _buildImageView();
  }

  Widget _buildImageView() {
    switch (imagePath.imageType) {
      case ImageType.svg:
        return SvgPicture.asset(
          imagePath,
          color: color,
          width: width,
          height: height,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.contain,
        );

      case ImageType.file:
        return Image.file(
          width: width,
          color: color,
          height: height,
          fit: fit ?? BoxFit.cover,
          colorBlendMode: colorBlendMode,
          File(imagePath.replaceFirst('file://', '')),
        );

      case ImageType.network:
        return CachedNetworkImage(
          color: color,
          width: width,
          height: height,
          imageUrl: imagePath,
          fit: fit ?? BoxFit.cover,
          colorBlendMode: colorBlendMode,
          filterQuality: FilterQuality.medium,
          errorWidget: (context, url, error) => Image.asset(width: width, height: height, 'assets/app_icon.png', fit: fit ?? BoxFit.cover),
          placeholder: (context, url) => Container(decoration: BoxDecoration(borderRadius: borderRadius ?? BorderRadius.zero, color: context.colorScheme.secondary.withValues(alpha: 0.35))).shimmer(),
        );

      case ImageType.png:
        return Image.asset(imagePath, color: color, width: width, height: height, fit: fit ?? BoxFit.cover, colorBlendMode: colorBlendMode);
    }
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    final lower = toLowerCase();
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (lower.endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file }
