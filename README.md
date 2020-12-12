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
curl -s http://localhost:3042/courses/blueprinter > /dev/null
curl -s http://localhost:3042/courses/active_model_serializer > /dev/null
curl -s http://localhost:3042/courses/panko_serializer > /dev/null
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

**ActiveModelSerializers (0.10 with Attributes Adapter)**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/active_model_serializer"
```

**PankoSerializer**
```shell
ab -n 15 -c 1 "http://localhost:3042/courses/panko_serializer"
```

Latest Results
--------------

Versions:
- Ruby `2.7.2`
- Rails `6.0.3.4`
- cache_crispies `1.1.3`
- fast_jsonapi `1.5`
- jbuilder `2.9.1`
- panko_serializer `0.7.4`

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
Document Length:        886551 bytes

Concurrency Level:      1
Time taken for tests:   1.164 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13305000 bytes
HTML transferred:       13298265 bytes
Requests per second:    12.89 [#/sec] (mean)
Time per request:       77.589 [ms] (mean)
Time per request:       77.589 [ms] (mean, across all concurrent requests)
Transfer rate:          11164.15 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:    63   77  17.1     74     129
Waiting:       62   77  17.1     74     128
Total:         63   78  17.1     75     129

Percentage of the requests served within a certain time (ms)
  50%     71
  66%     79
  75%     80
  80%     91
  90%     94
  95%    129
  98%    129
  99%    129
 100%    129 (longest request)
 ```
_Note that caching is enabled for these serializers, so it's not really a fair comparison to the others below, but we're including it here anyway_

### Cache Crispies (uncached)
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:        
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/cache_crispies
Document Length:        905763 bytes

Concurrency Level:      1
Time taken for tests:   9.221 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13593180 bytes
HTML transferred:       13586445 bytes
Requests per second:    1.63 [#/sec] (mean)
Time per request:       614.764 [ms] (mean)
Time per request:       614.764 [ms] (mean, across all concurrent requests)
Transfer rate:          1439.53 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   562  615  19.0    615     640
Waiting:      561  614  19.0    614     639
Total:        562  615  19.0    615     640

Percentage of the requests served within a certain time (ms)
  50%    613
  66%    619
  75%    631
  80%    635
  90%    637
  95%    640
  98%    640
  99%    640
 100%    640 (longest request)
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
Document Length:        1282240 bytes

Concurrency Level:      1
Time taken for tests:   15.604 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      19240335 bytes
HTML transferred:       19233600 bytes
Requests per second:    0.96 [#/sec] (mean)
Time per request:       1040.287 [ms] (mean)
Time per request:       1040.287 [ms] (mean, across all concurrent requests)
Transfer rate:          1204.12 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   922 1040 108.8   1026    1364
Waiting:      922 1039 108.8   1025    1363
Total:        923 1040 108.8   1026    1364

Percentage of the requests served within a certain time (ms)
  50%   1018
  66%   1047
  75%   1062
  80%   1081
  90%   1164
  95%   1364
  98%   1364
  99%   1364
 100%   1364 (longest request)
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
Document Length:        905763 bytes

Concurrency Level:      1
Time taken for tests:   25.196 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13593180 bytes
HTML transferred:       13586445 bytes
Requests per second:    0.60 [#/sec] (mean)
Time per request:       1679.711 [ms] (mean)
Time per request:       1679.711 [ms] (mean, across all concurrent requests)
Transfer rate:          526.86 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:  1546 1680 130.2   1637    2006
Waiting:     1546 1679 130.2   1636    2005
Total:       1546 1680 130.2   1637    2006

Percentage of the requests served within a certain time (ms)
  50%   1635
  66%   1642
  75%   1748
  80%   1790
  90%   1894
  95%   2006
  98%   2006
  99%   2006
 100%   2006 (longest request)
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
Document Length:        905751 bytes

Concurrency Level:      1
Time taken for tests:   13.965 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      13593000 bytes
HTML transferred:       13586265 bytes
Requests per second:    1.07 [#/sec] (mean)
Time per request:       931.017 [ms] (mean)
Time per request:       931.017 [ms] (mean, across all concurrent requests)
Transfer rate:          950.53 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   791  931  98.1    935    1123
Waiting:      790  930  97.2    935    1115
Total:        791  931  98.1    935    1123

Percentage of the requests served within a certain time (ms)
  50%    925
  66%    957
  75%    994
  80%   1024
  90%   1093
  95%   1123
  98%   1123
  99%   1123
 100%   1123 (longest request)
```

### ActiveModelSerializers (0.10 with "Attributes Adapter")
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:        
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/active_model_serializer
Document Length:        945951 bytes

Concurrency Level:      1
Time taken for tests:   20.992 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      14196000 bytes
HTML transferred:       14189265 bytes
Requests per second:    0.71 [#/sec] (mean)
Time per request:       1399.443 [ms] (mean)
Time per request:       1399.443 [ms] (mean, across all concurrent requests)
Transfer rate:          660.42 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       0
Processing:  1244 1399 142.8   1379    1701
Waiting:     1243 1399 142.8   1378    1700
Total:       1244 1399 142.8   1379    1701

Percentage of the requests served within a certain time (ms)
  50%   1375
  66%   1392
  75%   1472
  80%   1524
  90%   1689
  95%   1701
  98%   1701
  99%   1701
 100%   1701 (longest request)
```

### PankoSerializers
```
This is ApacheBench, Version 2.3 <$Revision: 1843412 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:        
Server Hostname:        localhost
Server Port:            3042

Document Path:          /courses/panko_serializer
Document Length:        1087567 bytes

Concurrency Level:      1
Time taken for tests:   7.400 seconds
Complete requests:      15
Failed requests:        0
Total transferred:      16320240 bytes
HTML transferred:       16313505 bytes
Requests per second:    2.03 [#/sec] (mean)
Time per request:       493.315 [ms] (mean)
Time per request:       493.315 [ms] (mean, across all concurrent requests)
Transfer rate:          2153.83 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   424  493  49.2    496     638
Waiting:      423  493  49.2    495     637
Total:        424  493  49.2    496     638

Percentage of the requests served within a certain time (ms)
  50%    493
  66%    502
  75%    505
  80%    507
  90%    537
  95%    638
  98%    638
  99%    638
 100%    638 (longest request)
```

Contributing
------------

If you'd like to include another caching framework, just open a pull request and I'll review it. Or feel free to open an issue with a suggested framework, and I'll get to adding it as I'm able.

License
-------
MIT
