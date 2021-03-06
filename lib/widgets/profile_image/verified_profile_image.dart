import 'package:delphis_app/widgets/verified_checkmark/verified_checkmark.dart';
import 'package:flutter/material.dart';

import 'profile_image.dart';

class VerifiedProfileImage extends StatelessWidget {
  static const SCALE_FACTOR = 0.85;

  final String profileImageURL;
  final double height;
  final double width;
  final BoxBorder border;
  final Alignment checkmarkAlignment;

  const VerifiedProfileImage({
    this.profileImageURL,
    this.height,
    this.width,
    this.border,
    this.checkmarkAlignment,
  }): super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height * SCALE_FACTOR,
      width: this.width,
      child: Stack(
        alignment: this.checkmarkAlignment,
        children: <Widget>[
          Container(
            alignment: -this.checkmarkAlignment,
            width: this.width,
            height: this.height,
            child: ProfileImage(
              height: this.height * SCALE_FACTOR, 
              width: this.width * SCALE_FACTOR,
              profileImageURL: this.profileImageURL,
              border: this.border,
            ),
          ),
          VerifiedCheckmark(
            height: this.height * SCALE_FACTOR / 2.5,
            width: this.width * SCALE_FACTOR / 2.5,
          ),
        ],
      )
    );
  }
}