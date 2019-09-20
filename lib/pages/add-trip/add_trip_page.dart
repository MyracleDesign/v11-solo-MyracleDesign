import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/date_time_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:repository/trip/models/models.dart';

class AddTripPage extends StatefulWidget {
  final bool isEditing;
  final Trip trip;

  final Function({
    @required String title,
    String destination,
    DateTime startDate,
    DateTime endDate,
    String photoUrl,
  }) onSave;

  AddTripPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.trip,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;

  DateTime _startDate;
  DateTime _endDate;

  bool get isEditing => widget.isEditing;

  var _titleController = TextEditingController();
  var _destinationController = TextEditingController();
  var _startDateController = TextEditingController();
  var _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      _titleController.text = widget.trip.title;
      _destinationController.text = widget.trip.destination;
      _startDateController.text =
          DateFormat.yMMMd().format(widget.trip.startDate);
      _endDateController.text = DateFormat.yMMMd().format(widget.trip.endDate);
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            widget.onSave(
              title: _titleController.text,
              destination: _destinationController.text.isNotEmpty
                  ? _destinationController.text
                  : null,
              startDate: _startDate,
              endDate: _endDate,
            );
          }
        },
      ),
      appBar: AppBar(
        title: Text(isEditing ? "Edit Trip" : "Create Trip"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                autofocus: !isEditing,
                decoration: InputDecoration(
                  hintText: "Trip Title",
                ),
                controller: _titleController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a Title";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Destination"),
                controller: _destinationController,
              ),
              DateTimePicker(
                hintText: "Start Date",
                initValue: isEditing ? widget.trip.startDate : DateTime.now(),
                dateController: _startDateController,
                onSelectValue: (DateTime selectedDate) {
                  setState(() {
                    _startDate = selectedDate;
                  });
                },
              ),
              DateTimePicker(
                hintText: "End Date",
                initValue: isEditing ? widget.trip.endDate : DateTime.now(),
                dateController: _endDateController,
                onSelectValue: (DateTime selectedDate) {
                  setState(() {
                    _endDate = selectedDate;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Card(
                  child: InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _image == null
                              ? Container(height: 200, child: Icon(Icons.image))
                              : Image.file(_image),
                        ],
                      ),
                      onTap: () async {
                        var image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          _image = image;
                        });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
