import 'package:ical/src/abstract.dart';
import 'package:ical/src/properties.dart';
import 'package:ical/src/utils.dart' as utils;

class ICalendar extends IComponent {
  List<ICalendarElement> _elements = <ICalendarElement>[];
  String company;
  String product;
  String lang;
  Duration refreshInterval;

  ICalendar({
    this.company = 'dartclub',
    this.product = 'ical/serializer',
    this.lang = 'EN',
    this.refreshInterval,
  });

  addAll(List<ICalendarElement> elements) => _elements.addAll(elements);
  addElement(ICalendarElement element) => _elements.add(element);

  @override
  String serialize() {
    var out = StringBuffer()
      ..writeln('BEGIN:VCALENDAR')
      ..writeln('VERSION:2.0')
      ..writeln('PRODID://${company}//${product}//${lang}');

    if (refreshInterval != null) {
      out.writeln(
          'REFRESH-INTERVAL;VALUE=DURATION:${utils.formatDuration(refreshInterval)}');
    }

    for (ICalendarElement element in _elements) {
      out.write(element.serialize());
    }

    out.writeln('END:VCALENDAR');
    return out.toString();
  }
}
