import 'package:adyah_wholesale/components/html/index.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:flutter/material.dart';

Padding descriptionWidget(var data) {
  print("=== descriptionWidget ===>>>${descriptionWidget.toString().length}");

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withOpacity(0.3),
        ),
        child: ExpansionTile(
          shape: InputBorder.none,
          title: text("DESCRIPTION"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
                data.description!,
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        )),
  );
}
