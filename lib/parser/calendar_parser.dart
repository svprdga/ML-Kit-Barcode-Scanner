part of ml_kit_barcode_scanner;

class CalendarParser extends BaseParser {
  //***************************** PUBLIC METHODS *************************** //

  @override
  BarcodeCalendarEvent parse(BarcodeEntity entity) {
    return BarcodeCalendarEvent(
        valueType: BarcodeValueType.CALENDAR_EVENT,
        rawValue: entity.rawValue,
        start: entity.calendarStart != null
            ? DateTime.parse(entity.calendarStart!)
            : null,
        end: entity.calendarEnd != null
            ? DateTime.parse(entity.calendarEnd!)
            : null,
        description: entity.calendarDescription,
        location: entity.calendarLocation,
        organizer: entity.calendarOrganizer,
        status: entity.calendarStatus,
        summary: entity.calendarSummary);
  }
}
