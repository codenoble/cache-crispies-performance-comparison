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
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/cache_crispies_cached
Document Length:        887062 bytes

Concurrency Level:      1
Time taken for tests:   1.235 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13312665 bytes
HTML transferred:       13305930 bytes
Requests per second:    12.14 [#/sec] (mean)
Time per request:       82.350 [ms] (mean)
Time per request:       82.350 [ms] (mean, across all concurrent requests)
Transfer rate:          10524.76 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:    55   82  23.5     76     162
Waiting:       55   81  23.5     76     162
Total:         56   82  23.5     76     162

Percentage of the requests served within a certain time (ms)
  50%     76
  66%     77
  75%     83
  80%     87
  90%     89
  95%    162
  98%    162
  99%    162
 100%    162 (longest request)
 ```
_Note that caching is enabled for these serializers, so it's not really a fair comparison to the others below, but we're including it here anyway_

### Cache Crispies (uncached)
```
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/cache_crispies
Document Length:        887062 bytes

Concurrency Level:      1
Time taken for tests:   7.741 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13312665 bytes
HTML transferred:       13305930 bytes
Requests per second:    1.94 [#/sec] (mean)
Time per request:       516.065 [ms] (mean)
Time per request:       516.065 [ms] (mean, across all concurrent requests)
Transfer rate:          1679.46 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   437  516  59.0    517     611
Waiting:      436  515  59.1    517     611
Total:        437  516  59.0    517     611

Percentage of the requests served within a certain time (ms)
  50%    510
  66%    546
  75%    572
  80%    587
  90%    588
  95%    611
  98%    611
  99%    611
 100%    611 (longest request)
```
_Note that caching is not enabled for these serializers, so there's no cheating going on there_

### Fast JSONAPI
```
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/fast_jsonapi
Document Length:        1255879 bytes

Concurrency Level:      1
Time taken for tests:   12.530 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      18844920 bytes
HTML transferred:       18838185 bytes
Requests per second:    1.20 [#/sec] (mean)
Time per request:       835.350 [ms] (mean)
Time per request:       835.350 [ms] (mean, across all concurrent requests)
Transfer rate:          1468.71 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   769  835  50.7    863     897
Waiting:      769  835  50.7    862     896
Total:        770  835  50.7    863     897

Percentage of the requests served within a certain time (ms)
  50%    859
  66%    874
  75%    885
  80%    889
  90%    895
  95%    897
  98%    897
  99%    897
 100%    897 (longest request)
```
_Note that because Fast JSON API only supports the JSON:API standard, the exact format doesn't match the others. But all of the same data should still be included in the response._

### Jbuilder
```
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/jbuilder
Document Length:        887062 bytes

Concurrency Level:      1
Time taken for tests:   16.607 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13312665 bytes
HTML transferred:       13305930 bytes
Requests per second:    0.90 [#/sec] (mean)
Time per request:       1107.140 [ms] (mean)
Time per request:       1107.140 [ms] (mean, across all concurrent requests)
Transfer rate:          782.84 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:  1020 1107  75.8   1153    1198
Waiting:     1019 1107  75.7   1152    1198
Total:       1020 1107  75.8   1153    1198

Percentage of the requests served within a certain time (ms)
  50%   1150
  66%   1161
  75%   1177
  80%   1182
  90%   1197
  95%   1198
  98%   1198
  99%   1198
 100%   1198 (longest request)
```

Contributing
------------

If you'd like to include another caching framework, just open a pull request and I'll review it. Or feel free to open an issue with a suggested framework, and I'll get to adding it as I'm able.

License
-------
MIT
