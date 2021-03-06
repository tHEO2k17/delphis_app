import 'package:delphis_app/data/repository/flair.dart';
import 'package:delphis_app/data/repository/moderator.dart';
import 'package:delphis_app/data/repository/participant.dart';
import 'package:delphis_app/design/sizes.dart';
import 'package:delphis_app/design/text_theme.dart';
import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  final Moderator moderator;
  final Participant participant;
  final double height;

  const PostTitle({
    Key key,
    @required this.moderator,
    @required this.participant,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: If the post is an announcement update the name to be something like `The mysterious <name>` with
    // different embedded fonts. the preamble should be the nonAnon text but at 13 font, w400. The name should
    // be the anon text style.
    final textKey =
        this.key == null ? null : Key('${this.key.toString}-displayName');

    var name = Text(
        '${participant.gradientColor} #${participant.participantID}',
        style: TextThemes.discussionPostAuthorAnon,
        key: textKey);
    if (participant.participantID == 0) {
      // This is the moderator
      name = Text(moderator.userProfile.displayName,
          style: TextThemes.discussionPostAuthorNonAnon, key: textKey);
    } else if (!participant.isAnonymous) {
      // Need to pass the profile down from the backend.
    }

    return Container(
      height: this.height,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          name,
          SizedBox(width: SpacingValues.small),
          PostTitleFlair(
              flair: this.participant.flair,
              height: this.height,
              key: this.key == null
                  ? null
                  : Key('${this.key.toString()}-flair')),
        ],
      ),
    );
  }
}

class PostTitleFlair extends StatelessWidget {
  final Flair flair;
  final double height;

  const PostTitleFlair({
    Key key,
    @required this.flair,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (flair != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            key: this.key == null ? null : Key('${this.key.toString()}-icon'),
            width: this.height,
            height: this.height,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                alignment: Alignment.center,
                image: NetworkImage(flair.imageURL),
              ),
            ),
          ),
          SizedBox(width: SpacingValues.xxSmall),
          Text(
            flair.displayName,
            key: this.key == null
                ? null
                : Key('${this.key.toString()}-display-name'),
            style: kThemeData.textTheme.headline3,
          )
        ],
      );
    } else {
      return Container(
          height: 0,
          width: 0,
          key: this.key == null
              ? null
              : Key('${this.key.toString()}-empty-container'));
    }
  }
}
