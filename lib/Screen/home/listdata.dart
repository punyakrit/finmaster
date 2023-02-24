import 'package:finmaster/Screen/home/1.dart';

List<money> geter() {
  money upwork = money();
  upwork.name = 'upwork';
  upwork.fee = '650';
  upwork.time = 'today';
  upwork.image = 'up.png';
  upwork.buy = false;

  money starbucks = money();
  starbucks.name = 'Starbucks';
  starbucks.fee = '15';
  starbucks.time = 'today';
  starbucks.buy = true;
  starbucks.image = 'starbuck.png';

  money transfer = money();
  transfer.buy = true;
  transfer.fee = '100';
  transfer.image = 'credit.png';
  transfer.name = 'transfer for sam';
  transfer.time = 'jan 30, 2023';

  return [
    upwork,
    starbucks,
    transfer,
    upwork,
    starbucks,
  ];
}
