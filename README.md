# Nava Timekeeper

Calculates your Nava Timekeeper Math for you.

Assumes a goal of 93.5% billable, and that you do not wish to work more than the minimum hours for this time period (aka 40/wk).

Note this program outputs exact minutes, i.e. 4h:23m (4.39h), while in reality we use 15m (0.25h) blocks at the smallest.

Clock & Decimal outputs round to two places, CSV is exact.

## Installation

Clone the repo

### Docker
```bash
docker build -t nava_timekeeper --rm .
docker run -it  --name nava_timekeeper --rm nava_timekeeper
```

### rbenv
```bash
cd nava_timekeeper
rbenv install 3.0.3 #or your preferred env manager
rbenv local 3.0.3

gem install bundler
bundle install
```

## Usage

Figuring out your budget for a time period with 88 hours (default), and two days planned leave

```bash
$ ./nava_timekeeper -l 16
For a time period of 88 with 16.0 hours leave:
Billable hours goal: 67.32
 Nonbillable budget: 4.68
```

Checking your usage at submit, for a 80 hour time period, with a half day sick & a holiday

```bash
$ ./nava_timekeeper --leave 12 --minimum 80
For a time period of 80 with 12.0 hours leave:
Billable hours goal: 63.58
 Nonbillable budget: 4.42
```

Figuring out your billable minimum for a time period with 94 hours and no leave, shown in HH:MM

```bash
./nava_timekeeper -m 80 -f clock
For a time period of 80 with 0h leave:
Billable hours goal: 74h:48m
 Nonbillable budget: 5h:12m
```

Getting a CSV output for further processing.

```bash
./nava_timekeeper --format csv
minimum_hours,leave,billable_minimum,nonbillable_budget
88,0,82.28,5.719999999999999
```
