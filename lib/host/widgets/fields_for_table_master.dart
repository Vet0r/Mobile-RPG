import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../styles/custom_theme.dart';
import 'edit_button.dart';

fieldsFortableMaster(
    bool isNumber,
    String campaignId,
    String fieldFB,
    String field,
    BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? documents,
    {bool? canEdit}) {
  var controller = TextEditingController();
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$field: ${documents?.get(fieldFB)}",
              style: TextStyle(fontSize: 20, color: CustomTeheme.text),
            ),
            fieldFB == "roled_dice"
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: canEdit == null
                        ? editButton(
                            isNumber, campaignId, fieldFB, documents, context)
                        : canEdit == false
                            ? Container()
                            : editButton(isNumber, campaignId, fieldFB,
                                documents, context),
                  ),
          ],
        ),
        const Divider(
          height: 0.1,
          thickness: 2,
        ),
      ],
    ),
  );
}
