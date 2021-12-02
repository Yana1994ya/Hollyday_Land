import "package:flutter/material.dart";
import "package:hollyday_land/providers/filter.dart";

abstract class AttractionFilter {
  const AttractionFilter();

  Map<String, Iterable<String>> get parameters;

  MaterialPageRoute get filterPage;

  FilterProvider createProvider();
}
