import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CardTypee { amex, discover, mastercard, visa, jcb, dinersclib, unknown }

class CardNumberValidator {
  static var amexRegex = RegExp(r'((34)|(37))');
  static var discoverRegex = RegExp(r'((6[45])|(6011))');
  static var mastercardRegex = RegExp(
      r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))');
  static var visaRegex = RegExp(r'[4]');
  static var jcbRegex = RegExp(r'(352[89]|35[3-8][0-9])');
  static var dinersClubRegex = RegExp(r'((30[0-5])|(3[89])|(36)|(3095))');

  static CardTypee getCardType(String cardNumber) {
    if (cardNumber.isEmpty) return CardTypee.unknown;
    if (cardNumber.startsWith(amexRegex)) {
      return CardTypee.amex;
    } else if (cardNumber.startsWith(discoverRegex)) {
      return CardTypee.discover;
    } else if (cardNumber.startsWith(mastercardRegex)) {
      return CardTypee.mastercard;
    } else if (cardNumber.startsWith(visaRegex)) {
      return CardTypee.visa;
    } else if (cardNumber.startsWith(jcbRegex)) {
      return CardTypee.jcb;
    } else if (cardNumber.startsWith(dinersClubRegex)) {
      return CardTypee.dinersclib;
    } else {
      return CardTypee.unknown;
    }
  }

  static Widget getCardIcon(CardTypee cardtype) {
    switch (cardtype) {
      case CardTypee.amex:
        return Image.asset(
          "assets/images/american_express.png",
          width: 30,
          height: 30,
        );
      case CardTypee.discover:
        return Image.asset(
          "assets/images/discover.png",
          width: 30,
          height: 30,
        );
      case CardTypee.mastercard:
        return Image.asset(
          "assets/images/mastercard.png",
          width: 30,
          height: 30,
        );
      case CardTypee.visa:
        return Image.asset(
          "assets/images/visa.png",
          width: 30,
          height: 30,
        );

      case CardTypee.jcb:
        return Image.asset(
          "assets/images/jcb.png",
          width: 30,
          height: 30,
        );
      case CardTypee.dinersclib:
        return Image.asset(
          "assets/images/dinners_club.png",
          width: 30,
          height: 30,
        );
      case CardTypee.unknown:
        return const Icon(
          Icons.credit_card,
          size: 30,
        );
      default:
        return const Icon(Icons.credit_card);
    }
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;
    final String newTextFiltered = newText.replaceAll(RegExp(r'[^\d]'), '');
    final int selectionIndexFromRight = newText.length - newValue.selection.end;
    int offset = 0;
    final StringBuffer newTextBuffer = StringBuffer();
    for (int i = 0; i < newTextFiltered.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newTextBuffer.write('-');
        if (newValue.selection.end >= i + offset) {
          offset++;
        }
      }
      newTextBuffer.write(newTextFiltered[i]);
    }
    return TextEditingValue(
        text: newTextBuffer.toString(),
        selection: TextSelection.collapsed(
            offset: newTextBuffer.length - selectionIndexFromRight));
  }
}
