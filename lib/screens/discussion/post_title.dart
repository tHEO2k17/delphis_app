import 'package:delphis_app/models/discussion.dart';
import 'package:delphis_app/widgets/profile_image/profile_image.dart';
import 'package:delphis_app/widgets/profile_image/verified_profile_image.dart';
import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  final Discussion discussion;
  final int index;

  const PostTitle({
    this.discussion,
    this.index,
  }): super();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var difference = now.difference(this.discussion.posts[this.index].createdAtAsDateTime());
    var differenceToDisplay = '${difference.inMinutes}m';
    if (difference.inMinutes > 60) {
      differenceToDisplay = '${difference.inHours}h';
      if (difference.inHours > 24) {
        differenceToDisplay = '${difference.inDays}d';
        if (difference.inDays > 30) {
          differenceToDisplay = '>30d';
        }
      }
    }

    const nameTextStyle = const TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w500);
    const rhsTextStyle = const TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500);

    return Container(
      child: new Row(
        children: <Widget>[
          Text('Anonymous something', style: nameTextStyle),
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(differenceToDisplay, style: rhsTextStyle),
          ),
          Container(
            padding: EdgeInsets.only(left: 4.0, right: 4.0),
            child: Text('•', style: rhsTextStyle)
          ),
          VerifiedProfileImage(
            height: 20.0,
            width: 20.0,
            profileImageURL: this.discussion.moderator.userProfile.profileImageURL,
            checkmarkAlignment: Alignment.bottomRight,
          ),
          Container(
            padding: EdgeInsets.only(left: 2.0),
            child: Text('Invited by ${this.discussion.moderator.userProfile.displayName}', style: rhsTextStyle),
          ),
        ],
      ),
    );
  }
}