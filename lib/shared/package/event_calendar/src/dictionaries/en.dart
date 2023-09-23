import '../../flutter_event_calendar.dart';

class En {
  static Map fullMonthNames = const {
    'en': {
      CalendarType.JALALI: [
        'Farvardin',
        'Ordibehesht',
        'Khordad',
        'Tir',
        'Mordad',
        'Shahrivar',
        'Mehr',
        'Aban',
        'Azar',
        'Dey',
        'Bahman',
        'Esfand'
      ],
      CalendarType.GREGORIAN: [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ]
    }
  };
  static Map shortMonthNames = const {
    'en': {
      CalendarType.JALALI: [
        'Far',
        'Ord',
        'Kho',
        'Tir',
        'Mor',
        'Sha',
        'Mehr',
        'Aban',
        'Azar',
        'Dey',
        'Bah',
        'Esf'
      ],
      CalendarType.GREGORIAN: [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ]
    }
  };

  static Map fullDayNames = const {
    'en': {
      CalendarType.JALALI: [
        'Saturday',
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
      ],
      CalendarType.GREGORIAN: [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
      ]
    }
  };
  static Map shortDayNames = const {
    'en': {
      CalendarType.JALALI: ['SAT', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI'],
      CalendarType.GREGORIAN: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
    }
  };
  static Map titles = const {
    'en': {
      'empty': 'Empty',
      'month_selector': 'Choose a month',
      'year_selector': 'Choose a year',
      'day_selector': 'choose a day'
    }
  };

  static Map directionIsRTL = {'en': false};
}
