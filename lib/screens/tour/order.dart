import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/forms/card_number_formatter.dart";
import "package:hollyday_land/forms/expiration_formatter.dart";
import "package:hollyday_land/models/http_exception.dart";
import "package:hollyday_land/models/tour/tour.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class TourOrder extends StatelessWidget {
  final Tour tour;
  final DateTime date;

  const TourOrder({Key? key, required this.tour, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order ${tour.name}",
          overflow: TextOverflow.fade,
        ),
      ),
      body: loginProvider.currentUser == null
          ? ProfileScreen.loginBody(context, loginProvider)
          : _LoggedInTourOrder(
              tour: tour,
              date: date,
              hdToken: loginProvider.hdToken!,
            ),
    );
  }
}

class _LoggedInTourOrder extends StatefulWidget {
  final Tour tour;
  final DateTime date;
  final String hdToken;

  const _LoggedInTourOrder(
      {Key? key, required this.tour, required this.date, required this.hdToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TourOrderState();
}

class _TourOrderState extends State<_LoggedInTourOrder> {
  final _formKey = GlobalKey<FormState>();
  bool submitting = false;
  String? name;
  String? phoneNumber;
  String? creditCard;
  String? expire;
  String? cvv;

  String get priceString {
    return widget.tour.price.toStringAsFixed(2) +
        "\$ (" +
        (widget.tour.group ? "par group" : "par person") +
        ")";
  }

  void onSuccess(dynamic reservation) {
    final reservationId = reservation as int;

    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text("Reservation successful"),
          content: Text("The reservation completed successfully, "
              "reservation number $reservationId"),
          actions: [
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Then exit the record screen upon completion
      // Notify the caller a refresh is recommended
      Navigator.of(context).pop(true);
    });
  }

  void onFail(dynamic error) {
    final String message;

    if (error is BadRequest) {
      message = "Failed with status ${error.code}, message:${error.message}";
    } else {
      message = error.toString();
    }

    // Let the user know upload failed
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text("Reservation failed"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Allow them to re-try at a later date
      setState(() {
        submitting = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(
              widget.tour.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (widget.tour.package != null)
              Text(
                widget.tour.package!.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            Text("Date: " + DateFormat.MMMd().format(widget.date)),
            Text("Price: " + priceString),
            // Full name
            TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a name";
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Full name",
              ),
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                name = value;
              },
            ),
            // Phone number
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a phone number";
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                labelText: "Phone number",
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                phoneNumber = value;
              },
            ),
            // Credit card
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
              ],
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.credit_card),
                hintText: "**** **** **** ****",
                labelText: "Card Number",
                counterText: "",
              ),
              maxLength: 19,
              onSaved: (value) {
                creditCard = value;
              },
            ),
            // Expiration and cvv
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ExpirationFormatter(),
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "mm / yy",
                          labelText: "Exp",
                          counterText: "",
                        ),
                        maxLength: 7,
                        onSaved: (value) {
                          expire = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 55,
                      child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "***",
                            labelText: "CVV",
                            counterText: "",
                          ),
                          maxLength: 4,
                          onSaved: (value) {
                            cvv = value;
                          }),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: submitting
                      ? null
                      : () {
                          if (_formKey.currentState != null) {
                            final FormState state = _formKey.currentState!;

                            if (state.validate()) {
                              state.save();

                              setState(() {
                                submitting = true;
                              });
                              print("Reserve to: ${name!}");
                              ApiServer.post(
                                "attractions/api/tours/reserve",
                                "reservation",
                                {
                                  "token": widget.hdToken,
                                  "name": name,
                                  "phone": phoneNumber,
                                  "tour_id": widget.tour.id,
                                  "date": DateFormat("yyyy/MM/dd")
                                      .format(widget.date)
                                },
                              ).then(onSuccess, onError: onFail);
                            }
                          }
                        },
                  child: Text("Reserve"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
