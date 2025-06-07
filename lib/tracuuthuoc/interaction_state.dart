import 'package:flutter/material.dart';

final interactionDrugListNotifier = ValueNotifier<List<String>>([]);

void addInteractionDrug(String drugName) {
  final currentList = interactionDrugListNotifier.value;
  if (!currentList.contains(drugName)) {
    interactionDrugListNotifier.value = [...currentList, drugName];
  }
}

void removeInteractionDrug(String drugName) {
  final currentList = interactionDrugListNotifier.value;
  currentList.remove(drugName);
  interactionDrugListNotifier.value = [...currentList];
}
