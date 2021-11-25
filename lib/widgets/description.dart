import "package:flutter/material.dart";

class Description extends StatefulWidget {
  final String text;

  const Description({Key? key, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool expended = false;

  bool get willOverflow {
    final span = TextSpan(text: widget.text);

    final tp = TextPainter(
        maxLines: 4,
        textAlign: TextAlign.left,
        text: span,
        textDirection: TextDirection.ltr);

    tp.layout(maxWidth: MediaQuery.of(context).size.width - 16);
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    if (!willOverflow) {
      return Column(children: [
        Align(
          child: Text(
            "About:",
            style: Theme.of(context).textTheme.headline5,
          ),
          alignment: Alignment.topLeft,
        ),
        Text(widget.text),
      ]);
    } else {
      return Column(children: [
        Align(
          child: Text(
            "About:",
            style: Theme.of(context).textTheme.headline5,
          ),
          alignment: Alignment.topLeft,
        ),
        if (expended) Text(widget.text),
        if (!expended)
          Text(
            widget.text,
            maxLines: 4,
            overflow: TextOverflow.fade,
          ),
        TextButton(
            onPressed: () {
              setState(() {
                expended = !expended;
              });
            },
            child: Row(
              children: [
                Text("Read more"),
                Icon(expended ? Icons.expand_less : Icons.expand_more),
              ],
            ))
      ]);
    }
  }
}
