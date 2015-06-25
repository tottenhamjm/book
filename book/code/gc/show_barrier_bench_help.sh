$ ./barrier_bench.native -help
Benchmark for mutable, immutable
 
  barrier_bench.native [COLUMN ...]
 
Columns that can be specified are:
	name       - Name of the test.
	cycles     - Number of CPU cycles (RDTSC) taken.
	cycles-err - 95% confidence interval and R^2 error for cycles.
	~cycles    - Cycles taken excluding major GC costs.
	time       - Number of nano secs taken.
	time-err   - 95% confidence interval and R^2 error for time.
	~time      - Time (ns) taken excluding major GC costs.
	alloc      - Allocation of major, minor and promoted words.
	gc         - Show major and minor collections per 1000 runs.
	percentage - Relative execution time as a percentage.
	speedup    - Relative execution cost as a speedup.
	samples    - Number of samples collected for profiling.
 
R^2 error indicates how noisy the benchmark data is. A value of
1.0 means the amortized cost of benchmark is almost exactly predicated
and 0.0 means the reported values are not reliable at all.
Also see: http://en.wikipedia.org/wiki/Coefficient_of_determination
 
Major and Minor GC stats indicate how many collections happen per 1000
runs of the benchmarked function.
 
The following columns will be displayed by default:
	+name time percentage
 
To specify that a column should be displayed only if it has a non-trivial value,
prefix the column name with a '+'.
 
=== flags ===
 
  [-ascii]             Display data in simple ascii based tables.
  [-clear-columns]     Don't display default columns. Only show user specified
                       ones.
  [-display STYLE]     Table style (short, tall, line, blank or column). Default
                       short.
  [-geometric SCALE]   Use geometric sampling. (default 1.01)
  [-linear INCREMENT]  Use linear sampling to explore number of runs, example 1.
  [-no-compactions]    Disable GC compactions.
  [-quota SECS]        Time quota allowed per test (default 10s).
  [-save]              Save benchmark data to <test name>.txt files.
  [-stabilize-gc]      Stabilize GC between each sample capture.
  [-v]                 High verbosity level.
  [-width WIDTH]       width limit on column display (default 150).
  [-build-info]        print info about this build and exit
  [-version]           print the version of this build and exit
  [-help]              print this help text and exit
                       (alias: -?)
 