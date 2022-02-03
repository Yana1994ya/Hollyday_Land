import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/difficulty.dart";

class NewTrailDescription {
  final String name;
  final Difficulty difficulty;

  NewTrailDescription({required this.name, required this.difficulty});
}

class NewTrailForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewTrailFormState();
}

class _NewTrailFormState extends State<NewTrailForm> {
  final _formKey = GlobalKey<FormState>();
  Difficulty? _difficulty = Difficulty.easy;
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trail upload"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "Trail name"),
                controller: _nameController,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                child: const Text(
                  "Difficulty",
                  textAlign: TextAlign.start,
                ),
              ),
              ListTile(
                title: const Text("Easy"),
                leading: Radio<Difficulty>(
                  value: Difficulty.easy,
                  groupValue: _difficulty,
                  onChanged: (Difficulty? value) {
                    setState(() {
                      _difficulty = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Moderate"),
                leading: Radio<Difficulty>(
                  value: Difficulty.medium,
                  groupValue: _difficulty,
                  onChanged: (Difficulty? value) {
                    setState(() {
                      _difficulty = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Hard"),
                leading: Radio<Difficulty>(
                  value: Difficulty.hard,
                  groupValue: _difficulty,
                  onChanged: (Difficulty? value) {
                    setState(() {
                      _difficulty = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text("Upload"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(NewTrailDescription(
                        difficulty: _difficulty!,
                        name: _nameController.value.text));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
