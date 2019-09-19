import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:repository/trip/models/models.dart';

class AddTripPage extends StatefulWidget {
  final Function onSave;
  final bool isEditing;
  final Trip trip;

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

  String title;
  String description;

  File _image;

  var _startDateController = TextEditingController();

  var _endDateController = TextEditingController();

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
                  initialValue: isEditing ? widget.trip.title : "",
                  autofocus: !isEditing,
                  decoration: InputDecoration(
                    hintText: "Trip Title",
                  )),
              TextFormField(
                  initialValue: isEditing ? widget.trip.destination : "",
                  decoration: InputDecoration(hintText: "Destination")),
              TextFormField(
                decoration: InputDecoration(hintText: "Start Date"),
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate:
                        isEditing ? widget.trip.startDate : DateTime.now(),
                    lastDate: DateTime(2101),
                    firstDate: DateTime(2015, 8),
                  );
                  if (picked != null) {
                    var formattedDateTime =
                        new DateFormat.yMMMd().format(picked);
                    _startDateController.text = formattedDateTime.toString();
                  }
                },
                controller: _startDateController,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "End Date"),
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate:
                        isEditing ? widget.trip.startDate : DateTime.now(),
                    lastDate: DateTime(2101),
                    firstDate: DateTime(2015, 8),
                  );
                  if (picked != null) {
                    var formattedDateTime =
                        new DateFormat.yMMMd().format(picked);
                    _endDateController.text = formattedDateTime.toString();
                  }
                },
                controller: _endDateController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Card(
                    child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _image == null
                                ? Container(
                                    height: 200, child: Icon(Icons.image))
                                : Image.file(_image),
                          ],
                        ),
                        onTap: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image = image;
                          });
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
