class CronService {
  static final _instance = CronService._();
  final _activeJobs = <CronJob>{};

  CronService._();

  factory CronService() => _instance;

  CronJob schedule(Duration period, CronTask task, {Duration tick = const Duration(milliseconds: 50)}) {
    final job = CronJob._(period: period, task: task, tick: tick);
    _activeJobs.add(job);
    job.start();
    return job;
  }

  void cancelAll() {
    for (final job in _activeJobs) {
      job.cancel();
    }
    _activeJobs.clear();
  }

  void cancel(CronJob job) {
    job.cancel();
    _activeJobs.remove(job);
  }
}

typedef CronTask = Future<void> Function();

class CronJob {
  final Duration period;
  final CronTask task;
  final Duration tick;
  late Duration _remainingTime;
  bool _cancelled = false;

  CronJob._({required this.period, required this.task, required this.tick});

  bool get cancelled => _cancelled;

  void start() {
    if (_cancelled) return;
    _remainingTime = period;
    Future.delayed(tick, _doTick);
  }

  void cancel() {
    _cancelled = true;
  }

  void _doTick() {
    if (_cancelled) return;
    _remainingTime = _remainingTime - tick;
    if (_remainingTime <= const Duration(microseconds: 0)) {
      _remainingTime = const Duration(microseconds: 0);
      task.call().then((_) {
        if (!_cancelled) {
          start();
        }
      });
    } else {
      Future.delayed(tick, _doTick);
    }
  }
}
