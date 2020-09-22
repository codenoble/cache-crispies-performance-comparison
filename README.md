Cache Crispies Performance Comparison
=====================================

An example Rails app with endpoints rendered by the cache_crispies gem and others for benchmarking and comparison

About the tests
---------------

The application is seeded with random data for 1,000 `Course` records, each containing 5 related `Slide` records, for a total of 5,000 slide records and 6,000 records in all. Each endpoint will serialize out all of the data, but will hide the slides data for a course where `publised` is false. The data is eager loaded to avoid poor performance from N+1 queries.

**The following caching gems are currently included in this test:**
- [cache_crispies](https://github.com/codenoble/cache-crispies)
- [fast_jsonapi](https://github.com/Netflix/fast_jsonapi)
- [jbuilder](https://github.com/rails/jbuilder)

_Note that while these tests attempt to remain fair and unbiased. It should be remembered they were created by the author of the `cache_crispies` gem. You are encouraged to do your own testing on your own project before choosing a serializing framework._

Running the Performance Tests
-----------------------------

Ensure you have [`ab`](https://httpd.apache.org/docs/2.4/programs/ab.html) installed

Ensure you have a recent version of [Ruby](https://www.ruby-lang.org/en/) installed

Checkout the repository
```shell
git clone git@github.com:codenoble/cache-crispies-performance-comparison.git
cd cache-crispies-performance-comparison
```

Setup the Rails app
```shell
gem install bundler
bundle install
rails db:create db:migrate db:seed
```

Start the Rails server with
```shell
rails server -p 3042
```

In another terminal window, run this command to warm up the Rails server.
```shell
curl -s http://localhost:3042/courses/cache_crispies_cached > /dev/null
curl -s http://localhost:3042/courses/cache_crispies > /dev/null
curl -s http://localhost:3042/courses/fast_jsonapi > /dev/null
curl -s http://localhost:3042/courses/jbuilder > /dev/null
```

Run these commands to benchmark the requests to the different endpoints for each serializer

**Cache Crispies (cached)**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/cache_crispies_cached"
```

**Cache Crispies (uncached)**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/cache_crispies"
```

**Fast JSON API**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/fast_jsonapi"
```

**Jbuilder**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/jbuilder"
```

**Blueprinter**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/blueprinter"
```

Latest Results
--------------

Versions:
- Ruby `2.5.6`
- Rails `6.0.0`
- cache_crispies `1.0.1`
- fast_jsonapi `1.5`
- jbuilder `2.9.1`

### Cache Crispies (cached)
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/cache_crispies_cached
Document Length:        890509 bytes

Concurrency Level:      1
Time taken for tests:   1.045 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13364370 bytes
HTML transferred:       13357635 bytes
Requests per second:    14.35 [#/sec] (mean)
Time per request:       69.677 [ms] (mean)
Time per request:       69.677 [ms] (mean, across all concurrent requests)
Transfer rate:          12487.27 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:    63   69  10.0     66      95
Waiting:       63   69  10.0     65      95
Total:         64   70  10.0     66      95

Percentage of the requests served within a certain time (ms)
  50%     66
  66%     66
  75%     70
  80%     71
  90%     92
  95%     95
  98%     95
  99%     95
 100%     95 (longest request)
 ```
_Note that caching is enabled for these serializers, so it's not really a fair comparison to the others below, but we're including it here anyway_

### Cache Crispies (uncached)
```
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/cache_crispies
Document Length:        890509 bytes

Concurrency Level:      1
Time taken for tests:   7.680 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13364370 bytes
HTML transferred:       13357635 bytes
Requests per second:    1.95 [#/sec] (mean)
Time per request:       511.986 [ms] (mean)
Time per request:       511.986 [ms] (mean, across all concurrent requests)
Transfer rate:          1699.41 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   399  512  63.8    542     596
Waiting:      399  511  63.8    542     596
Total:        399  512  63.8    542     596

Percentage of the requests served within a certain time (ms)
  50%    539
  66%    550
  75%    563
  80%    577
  90%    593
  95%    596
  98%    596
  99%    596
 100%    596 (longest request)
```
_Note that caching is not enabled for these serializers, so there's no cheating going on there_

### Fast JSONAPI
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/fast_jsonapi
Document Length:        1258072 bytes

Concurrency Level:      1
Time taken for tests:   12.196 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      18877815 bytes
HTML transferred:       18871080 bytes
Requests per second:    1.23 [#/sec] (mean)
Time per request:       813.083 [ms] (mean)
Time per request:       813.083 [ms] (mean, across all concurrent requests)
Transfer rate:          1511.56 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       0
Processing:   799  813  11.5    814     834
Waiting:      798  812  11.5    813     834
Total:        799  813  11.5    814     834

Percentage of the requests served within a certain time (ms)
  50%    813
  66%    815
  75%    823
  80%    824
  90%    832
  95%    834
  98%    834
  99%    834
 100%    834 (longest request)
```
_Note that because Fast JSON API only supports the JSON:API standard, the exact format doesn't match the others. But all of the same data should still be included in the response._

### Jbuilder
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/jbuilder
Document Length:        890509 bytes

Concurrency Level:      1
Time taken for tests:   17.045 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13364370 bytes
HTML transferred:       13357635 bytes
Requests per second:    0.88 [#/sec] (mean)
Time per request:       1136.317 [ms] (mean)
Time per request:       1136.317 [ms] (mean, across all concurrent requests)
Transfer rate:          765.70 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   993 1136 162.5   1049    1378
Waiting:      993 1136 162.5   1049    1377
Total:        993 1136 162.5   1049    1378

Percentage of the requests served within a certain time (ms)
  50%   1049
  66%   1077
  75%   1348
  80%   1355
  90%   1362
  95%   1378
  98%   1378
  99%   1378
```

### Blueprinter
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/blueprinter
Document Length:        890497 bytes

Concurrency Level:      1
Time taken for tests:   9.779 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13364190 bytes
HTML transferred:       13357455 bytes
Requests per second:    1.53 [#/sec] (mean)
Time per request:       651.904 [ms] (mean)
Time per request:       651.904 [ms] (mean, across all concurrent requests)
Transfer rate:          1334.65 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   517  652  85.0    646     822
Waiting:      517  651  85.0    645     821
Total:        517  652  85.0    646     822

Percentage of the requests served within a certain time (ms)
  50%    634
  66%    659
  75%    729
  80%    752
  90%    762
  95%    822
  98%    822
  99%    822
 100%    822 (longest request)
```

Contributing
------------

If you'd like to include another caching framework, just open a pull request and I'll review it. Or feel free to open an issue with a suggested framework, and I'll get to adding it as I'm able.

License
-------
MIT
