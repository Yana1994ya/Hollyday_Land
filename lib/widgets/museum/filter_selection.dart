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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MuseumFilterProvider>(context);

    return Column(
      children: [
        Text("region:"),
        DropdownButton<Region?>(
          items: [
            DropdownMenuItem<Region?>(
              child: Text("any"),
              value: null,
            ),
            ...options.regions.map((region) => DropdownMenuItem<Region?>(
                  child: Text(region.name),
                  value: region,
                ))
          ],
          onChanged: provider.setRegion,
          value: provider.region == null
              ? null
              : options.regions
                  .firstWhere((element) => element.id == provider.region!.id),
        ),
        Text("domain:"),
        DropdownButton<MuseumDomain?>(
          items: [
            DropdownMenuItem<MuseumDomain?>(
              child: Text("any"),
              value: null,
            ),
            ...options.domains.map((domain) => DropdownMenuItem<MuseumDomain?>(
                  child: Text(domain.name),
                  value: domain,
                ))
          ],
          onChanged: provider.setDomain,
          value: provider.domain == null
              ? null
              : options.domains
                  .firstWhere((element) => element.id == provider.domain!.id),
        ),
      ],
    );
  }
}
