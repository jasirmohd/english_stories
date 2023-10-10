import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CommonNativeAdsWidget extends StatelessWidget {
  CommonNativeAdsWidget({super.key, this.nativeAd, required this.isSmall});

  NativeAd? nativeAd;

  bool isSmall;

  @override
  Widget build(BuildContext context) {
    return isSmall ? ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 320, // minimum recommended width
        minHeight: 90, // minimum recommended height
        maxWidth: 400,
        maxHeight: 90,
      ),
      child: AdWidget(ad: nativeAd!),
    ): ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 320, // minimum recommended width
        minHeight: 320, // minimum recommended height
        maxWidth: 400,
        maxHeight: 400,
      ),
      child: AdWidget(ad: nativeAd!),
    );
  }
}
