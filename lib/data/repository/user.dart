import 'package:delphis_app/bloc/gql_client/gql_client_bloc.dart';
import 'package:delphis_app/data/provider/queries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:json_annotation/json_annotation.dart' as JsonAnnotation;

import 'flair.dart';
import 'participant.dart';
import 'user_profile.dart';
import 'viewer.dart';

part 'user.g.dart';

const MAX_ATTEMPTS = 3;
const BACKOFF = 1;

class UserRepository {
  final GqlClientBloc clientBloc;

  const UserRepository({
    @required this.clientBloc,
  });

  Future<User> getMe({int attempt = 1}) async {
    final client = this.clientBloc.getClient();

    if (client == null && attempt <= MAX_ATTEMPTS) {
      return Future.delayed(Duration(seconds: BACKOFF * attempt), () {
        return getMe(attempt: attempt + 1);
      });
    } else if (client == null) {
      throw Exception(
          "Failed to get user because backend connection is severed");
    }

    final query = MeGQLQuery();

    final QueryResult result = await client
        .query(QueryOptions(documentNode: gql(query.query()), variables: {}));

    if (result.hasException) {
      throw result.exception;
    }
    return query.parseResult(result.data);
  }
}

@JsonAnnotation.JsonSerializable()
class User extends Equatable {
  final String id;
  final List<Participant> participants;
  final List<Viewer> viewers;
  final UserProfile profile;
  final List<Flair> flairs;

  List<Object> get props => [id, participants, viewers, profile];

  const User({
    this.id,
    this.participants,
    this.viewers,
    this.profile,
    this.flairs,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
