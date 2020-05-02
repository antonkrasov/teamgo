import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teamgo/models/activity.dart';
import 'package:teamgo/styles/colors.dart';
import 'package:teamgo/styles/text.dart';

final dateTimeFormatter = DateFormat.yMMMd();

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({
    Key key,
    @required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          'activity_details',
          arguments: this.activity,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildImage(),
          SizedBox(
            height: 8,
          ),
          _buildWhere(),
          SizedBox(
            height: 2,
          ),
          _buildWhen(),
          SizedBox(
            height: 2,
          ),
          _buildWho(),
          SizedBox(
            height: 6,
          ),
          _buildWhat(),
        ],
      ),
    );
  }

  Row _buildWhat() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            activity.what,
            style: TeamGoTextStyles.header,
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Row _buildWho() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.people,
          size: 14,
          color: TeamGoColors.secondaryText,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            activity.who,
            style: TeamGoTextStyles.secondaryText,
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Row _buildWhen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.timer,
          size: 14,
          color: TeamGoColors.secondaryText,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            dateTimeFormatter.format(
              activity.when,
            ),
            style: TeamGoTextStyles.secondaryText,
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Row _buildWhere() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.place,
          size: 14,
          color: TeamGoColors.secondaryText,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            activity.where,
            style: TeamGoTextStyles.secondaryText,
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  AspectRatio _buildImage() {
    return AspectRatio(
      aspectRatio: 1.77,
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // image loading placeholder...
            Icon(Icons.image),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Image.network(
                activity.image,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
