import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamgo/blocs/activities/activities_bloc.dart';
import 'package:teamgo/models/activity.dart';
import 'package:teamgo/styles/colors.dart';
import 'package:teamgo/styles/text.dart';
import 'package:teamgo/widgets/activity_card.dart';

class AddEditActivityScreen extends StatelessWidget {
  final Activity paramActivity;

  const AddEditActivityScreen({
    Key key,
    this.paramActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paramActivity == null ? 'Add Activity' : 'Edit Activtiy'),
      ),
      body: AddEditActivityForm(
        paramActivity: paramActivity,
      ),
    );
  }
}

class AddEditActivityForm extends StatefulWidget {
  final Activity paramActivity;

  const AddEditActivityForm({
    Key key,
    this.paramActivity,
  }) : super(key: key);

  @override
  _AddEditActivityFormState createState() => _AddEditActivityFormState();
}

class _AddEditActivityFormState extends State<AddEditActivityForm> {
  final TextEditingController _whatTextController = TextEditingController();
  final TextEditingController _whereTextController = TextEditingController();
  final TextEditingController _whenTextController = TextEditingController();
  final TextEditingController _whoTextController = TextEditingController();
  final TextEditingController _imageTextController = TextEditingController();

  final FocusNode _whereFocusNode = FocusNode();
  final FocusNode _whoFocusNode = FocusNode();
  final FocusNode _imageFocusNode = FocusNode();

  DateTime _pickedDateTime;

  @override
  void initState() {
    super.initState();

    if (this.widget.paramActivity != null) {
      final initialActivity = this.widget.paramActivity;

      _pickedDateTime = initialActivity.when;
      _whenTextController.text = _formatDateTime(_pickedDateTime);

      _whatTextController.text = initialActivity.what;
      _whereTextController.text = initialActivity.where;
      _whoTextController.text = initialActivity.who;
      _imageTextController.text = initialActivity.image;
    }
  }

  @override
  void dispose() {
    _whatTextController.dispose();
    _whereTextController.dispose();
    _whenTextController.dispose();
    _whoTextController.dispose();
    _imageTextController.dispose();

    _whereFocusNode.dispose();
    _whoFocusNode.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _buildWhat(),
              _buildWhere(),
              _buildWhen(context),
              _buildWho(),
              _buildImage(),
              SizedBox(
                height: 16,
              ),
              _buildActionButton()
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton _buildActionButton() {
    return RaisedButton(
      color: TeamGoColors.primaryColor,
      onPressed: () {
        _submit();
      },
      child: Text(
        this.widget.paramActivity == null ? 'Add' : 'Edit',
        style: TeamGoTextStyles.button,
      ),
    );
  }

  TextFormField _buildWho() {
    return TextFormField(
      controller: _whoTextController,
      textInputAction: TextInputAction.next,
      focusNode: _whoFocusNode,
      onFieldSubmitted: (_) {
        _imageFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        labelText: 'Who',
        icon: Icon(
          Icons.person,
        ),
      ),
    );
  }

  GestureDetector _buildWhen(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickDate();
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _whenTextController,
          decoration: InputDecoration(
            labelText: 'When',
            icon: Icon(
              Icons.timer,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildWhere() {
    return TextFormField(
      controller: _whereTextController,
      focusNode: _whereFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        _pickDate();
      },
      decoration: InputDecoration(
        labelText: 'Where',
        icon: Icon(
          Icons.place,
        ),
      ),
    );
  }

  TextFormField _buildWhat() {
    return TextFormField(
      autofocus: true,
      controller: _whatTextController,
      onFieldSubmitted: (_) {
        _whereFocusNode.requestFocus();
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'What',
        icon: Icon(
          Icons.local_activity,
        ),
      ),
    );
  }

  TextFormField _buildImage() {
    return TextFormField(
      controller: _imageTextController,
      focusNode: _imageFocusNode,
      textInputAction: TextInputAction.send,
      onFieldSubmitted: (_) {
        _submit();
      },
      decoration: InputDecoration(
        labelText: 'Image URL',
        icon: Icon(
          Icons.image,
        ),
      ),
    );
  }

  _submit() {
    final what = _whatTextController.text;
    final where = _whereTextController.text;
    final who = _whoTextController.text;
    final imageUrl = _imageTextController.text;

    if (what.isEmpty) {
      _showError('Please enter what');
      return;
    }

    if (where.isEmpty) {
      _showError('Please enter where');
      return;
    }

    if (_pickedDateTime == null) {
      _showError('Please enter when');
      return;
    }

    if (who.isEmpty) {
      _showError('Please enter who');
      return;
    }

    if (imageUrl.isEmpty) {
      _showError('Please enter image url');
      return;
    }

    Activity activity = Activity(
      id: this.widget.paramActivity == null
          ? null
          : this.widget.paramActivity.id,
      createdByUser: true,
      what: what,
      when: _pickedDateTime,
      where: where,
      who: who,
      image: imageUrl,
    );

    BlocProvider.of<ActivitiesBloc>(context).add(
      AddEditActivityEvent(activity),
    );

    Navigator.of(context).pop();
  }

  _showError(String text) {
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  _formatDateTime(DateTime time) {
    return dateTimeFormatter.format(time);
  }

  void _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _pickedDateTime == null
          ? DateTime.now().add(
              Duration(days: 1),
            )
          : _pickedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: 1000,
        ),
      ),
    );

    if (result != null) {
      _pickedDateTime = result;
      _whenTextController.text = _formatDateTime(result);
      _whoFocusNode.requestFocus();
    }
  }
}
