import 'dart:convert';

import 'package:counter/components/controls.dart';
import 'package:flutter/material.dart';
import "dart:math";

Future<void> changeValueDialog(
  BuildContext context,
  String itemTitle,
  String key,
  String itemValue,
  updateState,
  colorValue,
) {
  Controls controls = Controls();
  TextEditingController txtItemValue = TextEditingController();
  TextEditingController txtNewItemValue = TextEditingController();

  txtItemValue.text = itemValue.toString();
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Dialog(
              child: Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemTitle,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          enabled: false,
                          controller: txtItemValue,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusColor: Colors.grey,
                            hintText: "Old Value",
                            labelText: "Old Value",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          enabled: true,
                          autofocus: true,
                          controller: txtNewItemValue,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            labelStyle: TextStyle(color: Colors.grey),
                            focusColor: Colors.grey,
                            hintText: "",
                            labelText: "New Value",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  padding: EdgeInsets.all(20),
                                  color: Colors.deepPurple,
                                  onPressed: () async {
                                    controls.updateOnlyValue(
                                        key,
                                        int.parse(txtItemValue.text),
                                        int.parse(txtNewItemValue.text),
                                        updateState);
                                    controls.saveHistory(
                                        key,
                                        itemValue,
                                        txtNewItemValue.text,
                                        colorValue,
                                        "add",
                                        updateState);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Update",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ])));
        });
      });
}
