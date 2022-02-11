import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/activity.dart";
import "package:hollyday_land/models/trail/attraction.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/suitability.dart";
import "package:hollyday_land/models/trail/tags.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class NewTrailDescription {
  final String name;
  final Difficulty difficulty;
  final Set<int> activities;
  final Set<int> attractions;
  final Set<int> suitabilities;

  const NewTrailDescription({
    required this.name,
    required this.difficulty,
    required this.activities,
    required this.attractions,
    required this.suitabilities,
  });
}

class LoadingTrailForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrailTags>(
      future: TrailTags.retrieve(),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Trail upload"),
            ),
            body: Center(
              child: Text("error: ${snapshot.error}"),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Trail upload"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return NewTrailForm(tags: snapshot.data!);
        }
      },
    );
  }
}

class NewTrailForm extends StatefulWidget {
  final TrailTags tags;

  const NewTrailForm({Key? key, required this.tags}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewTrailFormState();
}

class _NewTrailFormState extends State<NewTrailForm> {
  final _formKey = GlobalKey<FormState>();
  Difficulty? _difficulty = Difficulty.easy;
  final _nameController = TextEditingController();
  final Set<TrailActivity> activities = {};
  final Set<TrailAttraction> attractions = {};
  final Set<TrailSuitability> suitabilities = {};

  List<Widget> subTitle(String text) {
    return [
      SizedBox(
        height: 5,
      ),
      Align(
        child: Text(
          text,
          textAlign: TextAlign.start,
        ),
      ),
    ];
  }

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
          child: ListView(
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
              ...subTitle("Difficulty"),
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
              ...subTitle("Activities"),
              FilterChips.choiceChips<TrailActivity>(
                items: widget.tags.activities,
                isSelected: activities.contains,
                toggle: (activity) {
                  setState(() {
                    if (activities.contains(activity)) {
                      activities.remove(activity);
                    } else {
                      activities.add(activity);
                    }
                  });
                },
                title: (activity) => activity.name,
                colorScheme: Theme.of(context).colorScheme,
              ),
              ...subTitle("Attractions"),
              FilterChips.choiceChips<TrailAttraction>(
                items: widget.tags.attractions,
                isSelected: attractions.contains,
                toggle: (attraction) {
                  setState(() {
                    if (attractions.contains(attraction)) {
                      attractions.remove(attraction);
                    } else {
                      attractions.add(attraction);
                    }
                  });
                },
                title: (attraction) => attraction.name,
                colorScheme: Theme.of(context).colorScheme,
              ),
              ...subTitle("Suitability"),
              FilterChips.choiceChips<TrailSuitability>(
                items: widget.tags.suitabilities,
                isSelected: suitabilities.contains,
                toggle: (suitability) {
                  setState(() {
                    if (suitabilities.contains(suitability)) {
                      suitabilities.remove(suitability);
                    } else {
                      suitabilities.add(suitability);
                    }
                  });
                },
                title: (suitability) => suitability.name,
                colorScheme: Theme.of(context).colorScheme,
              ),
              TextButton(
                child: Text("Upload"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop(NewTrailDescription(
                      difficulty: _difficulty!,
                      name: _nameController.value.text,
                      activities:
                          activities.map((activity) => activity.id).toSet(),
                      attractions: attractions
                          .map((attraction) => attraction.id)
                          .toSet(),
                      suitabilities: suitabilities
                          .map((suitability) => suitability.id)
                          .toSet(),
                    ));
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
