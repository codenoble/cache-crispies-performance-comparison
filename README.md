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
curl -s http://localhost:3042/courses/cache_crispies > /dev/null
curl -s http://localhost:3042/courses/fast_jsonapi > /dev/null
curl -s http://localhost:3042/courses/jbuilder > /dev/null
```

Run these commands to benchmark the requests to the different endpoints for each serializer

**Cache Crispies**
```shell
ab -n 15 -c 3 "http://localhost:3042/courses/cache_crispies"
```

**Fast JSON API**
```shell
ab -n 15 -c 3 "http://localhost:3042/courses/fast_jsonapi"
```

**Jbuilder**
```shell
ab -n 15 -c 3 "http://localhost:3042/courses/jbuilder"
```

Latest Results
--------------

Versions:
- Ruby `2.5.3`
- Rails `5.2.2`
- cache_crispies `0.1.1`
- fast_jsonapi `1.5`
- jbuilder `2.9.1`

### Cache Crispies
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

Concurrency Level:      3
Time taken for tests:   10.990 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13312665 bytes
HTML transferred:       13305930 bytes
Requests per second:    1.36 [#/sec] (mean)
Time per request:       2197.982 [ms] (mean)
Time per request:       732.661 [ms] (mean, across all concurrent requests)
Transfer rate:          1182.96 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   654 1995 713.9   2215    2953
Waiting:      653 1822 648.8   2058    2748
Total:        654 1995 713.9   2215    2953

Percentage of the requests served within a certain time (ms)
  50%   2193
  66%   2253
  75%   2567
  80%   2698
  90%   2877
  95%   2953
  98%   2953
  99%   2953
 100%   2953 (longest request)
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

Concurrency Level:      3
Time taken for tests:   16.571 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      18844920 bytes
HTML transferred:       18838185 bytes
Requests per second:    0.91 [#/sec] (mean)
Time per request:       3314.188 [ms] (mean)
Time per request:       1104.729 [ms] (mean, across all concurrent requests)
Transfer rate:          1110.57 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:  1106 3111 773.5   3164    4430
Waiting:     1100 2801 789.8   2911    4202
Total:       1107 3111 773.5   3164    4430

Percentage of the requests served within a certain time (ms)
  50%   3068
  66%   3466
  75%   3784
  80%   3784
  90%   3814
  95%   4430
  98%   4430
  99%   4430
 100%   4430 (longest request)
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

Concurrency Level:      3
Time taken for tests:   42.800 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13312665 bytes
HTML transferred:       13305930 bytes
Requests per second:    0.35 [#/sec] (mean)
Time per request:       8559.961 [ms] (mean)
Time per request:       2853.320 [ms] (mean, across all concurrent requests)
Transfer rate:          303.75 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:  3526 7748 1591.7   8306    9322
Waiting:     3525 7728 1587.3   8297    9320
Total:       3526 7748 1591.7   8306    9322

Percentage of the requests served within a certain time (ms)
  50%   8147
  66%   8506
  75%   8755
  80%   8793
  90%   8927
  95%   9322
  98%   9322
  99%   9322
 100%   9322 (longest request)
```

Contributing
------------

If you'd like to include another caching framework, just open a pull request and I'll review it. Or feel free to open an issue with a suggested framework, and I'll get to adding it as I'm able.

License
-------
MIT
