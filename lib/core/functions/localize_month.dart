String getMonth(int month) {
  const monthKeys = [
    '',
    'month_1',
    'month_2',
    'month_3',
    'month_4',
    'month_5',
    'month_6',
    'month_7',
    'month_8',
    'month_9',
    'month_10',
    'month_11',
    'month_12',
  ];

  if (month < 1 || month > 12) return '';

  return monthKeys[month];
}
