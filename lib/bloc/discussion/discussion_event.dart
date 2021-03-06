part of 'discussion_bloc.dart';

@immutable
abstract class DiscussionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DiscussionQueryEvent extends DiscussionEvent {
  final String discussionID;

  DiscussionQueryEvent({
    @required this.discussionID,
  }) : super();

  @override
  List<Object> get props => [this.discussionID];
}

class DiscussionErrorEvent extends DiscussionEvent {
  final Exception exception;

  DiscussionErrorEvent(this.exception) : super();

  @override
  List<Object> get props => [this.exception];
}

class DiscussionLoadedEvent extends DiscussionEvent {
  final Discussion discussion;

  DiscussionLoadedEvent(this.discussion) : super();

  @override
  List<Object> get props => [this.discussion];
}

class DiscussionPostsUpdatedEvent extends DiscussionEvent {
  final List<Post> posts;
  final DateTime timestamp;

  DiscussionPostsUpdatedEvent(this.posts, this.timestamp) : super();

  @override
  List<Object> get props => [this.posts, this.timestamp];
}

class MeParticipantUpdatedEvent extends DiscussionEvent {
  // Any of these may be null.
  final Participant meParticipant;

  MeParticipantUpdatedEvent({
    @required this.meParticipant,
  }) : super();

  @override
  List<Object> get props => [this.meParticipant];
}

class DiscussionPostAddEvent extends DiscussionEvent {
  final String postContent;

  @override
  List<Object> get props => [this.postContent];

  DiscussionPostAddEvent({
    @required this.postContent,
  }) : super();
}

class DiscussionPostAddedEvent extends DiscussionEvent {
  final Post post;

  @override
  List<Object> get props => [this.post];

  DiscussionPostAddedEvent({
    @required this.post,
  }) : super();
}

class SubscribeToDiscussionEvent extends DiscussionEvent {
  final String discussionID;
  final bool isSubscribed;

  SubscribeToDiscussionEvent(this.discussionID, this.isSubscribed) : super();

  @override
  List<Object> get props => [this.discussionID, this.isSubscribed];
}

class UnsubscribeFromDiscussionEvent extends DiscussionEvent {
  final String discussionID;
  final bool hasUnsubscribed;

  UnsubscribeFromDiscussionEvent(this.discussionID, this.hasUnsubscribed)
      : super();

  @override
  List<Object> get props => [this.discussionID, this.hasUnsubscribed];
}

class LocalPostCreateSuccess extends DiscussionEvent {
  final Post createdPost;
  final LocalPost localPost;

  LocalPostCreateSuccess({@required this.createdPost, @required this.localPost})
      : super();

  @override
  List<Object> get props => [this.createdPost?.id, this.localPost?.key];
}

class LocalPostCreateFailure extends DiscussionEvent {
  final LocalPost localPost;
  final DateTime now;

  LocalPostCreateFailure({@required this.localPost})
      : this.now = DateTime.now(),
        super();

  @override
  List<Object> get props => [this.localPost?.key, this.now];
}
