import 'package:uuid/uuid.dart';

final uuidGenerator = Uuid();

class Activity {
  final String id;
  final String who;
  final String what;
  final String where;
  final DateTime when;
  final String image;

  Activity({
    this.id,
    this.who,
    this.what,
    this.where,
    this.when,
    this.image,
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
}
