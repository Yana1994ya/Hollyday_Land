import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';
import 'package:hollyday_land/models/museum/museum_filter_options.dart';
import 'package:hollyday_land/models/region.dart';
import 'package:hollyday_land/providers/museum/museum_filter.dart';
import 'package:provider/provider.dart';

class FilterSelectionWidget extends StatelessWidget {
  final MuseumFilterOptions options;

  const FilterSelectionWidget({Key? key, required this.options})
      : super(key: key);

  Widget regionDropdown(MuseumFilterProvider filterProvider) {
    return DropdownButton<Region?>(
      items: [
        DropdownMenuItem<Region?>(
          child: Text("Any"),
          value: null,
        ),
        ...options.regions.map((region) => DropdownMenuItem<Region?>(
              child: Text(region.name),
              value: region,
            ))
      ],
      onChanged: filterProvider.setRegion,
      value: filterProvider.region == null
          ? null
          : options.regions
              .firstWhere((element) => element.id == filterProvider.region!.id),
    );
  }

  Widget domainDropdown(MuseumFilterProvider filterProvider) {
    return DropdownButton<MuseumDomain?>(
      items: [
        DropdownMenuItem<MuseumDomain?>(
          child: Text("Any"),
          value: null,
        ),
        ...options.domains.map((domain) => DropdownMenuItem<MuseumDomain?>(
              child: Text(domain.name),
              value: domain,
            ))
      ],
      onChanged: filterProvider.setDomain,
      value: filterProvider.domain == null
          ? null
          : options.domains
              .firstWhere((element) => element.id == filterProvider.domain!.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MuseumFilterProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Region:"),
              regionDropdown(provider),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Domain:"),
              domainDropdown(provider),
            ],
          ),
        ],
      ),
    );
  }
}
