import 'package:adyah_wholesale/card/card_date_validator.dart';
import 'package:adyah_wholesale/card/card_number_validator.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  CardTypee _cardType = CardTypee.unknown;
  @override
  Widget build(BuildContext context) {
    debugPrint("====== _cardType =========>$_cardType");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("New card")),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CardNumberValidator.getCardIcon(_cardType)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
                hintText: "XXXX-XXXX-XXXX-XXXX",
                labelText: "Card Number",
                counterText: '',
                isDense: true),
            maxLength: 19,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _cardType = CardNumberValidator.getCardType(value);
                debugPrint("==== _cardType ==>>>>>>>$_cardType");
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberFormatter()
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: 'Card Holder Name',
                labelStyle: TextStyle(color: colors.blackcolor),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Month/Year',
                hintText: 'MM/YY',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
              CardDateFormatter()
            ],
          )
        ],
      ),
    );
  }
}
