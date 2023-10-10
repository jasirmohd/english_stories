import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CommonBannerAdsWidget extends StatelessWidget {
  CommonBannerAdsWidget({super.key, required this.width, required this.height, this.bannerAd});

  int width,height;
  BannerAd? bannerAd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}
