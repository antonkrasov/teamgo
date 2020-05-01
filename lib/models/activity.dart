import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

final uuidGenerator = Uuid();

class Activity extends Equatable {
  final String id;
  final String who;
  final String what;
  final String where;
  final DateTime when;
  final String image;
  final bool createdByUser;

  Activity({
    this.id,
    this.who,
    this.what,
    this.where,
    this.when,
    this.image,
    this.createdByUser = false,
  });

  factory Activity.fromRaw(Map raw) {
    return Activity(
      id: uuidGenerator.v4(),
      who: raw['who'],
      what: raw['what'],
      where: raw['where'],
      when: DateTime.tryParse(
        raw['when'],
      ),
      image: raw['image'],
    );
  }

  @override
  List<Object> get props => [
        id,
        who,
        what,
        where,
        when,
        image,
        createdByUser,
      ];

  @override
  bool get stringify => true;
}
