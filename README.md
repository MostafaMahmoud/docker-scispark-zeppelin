# scispark-zeppelin

SciSpark Dockerfile based on [dylanmei/docker-zeppelin](https://github.com/dylanmei/docker-zeppelin). Updates include:

- stand-alone configuration of HDFS
- installation of Anaconda Python
- Spark reconfigured for Anaconda Python

This image contains:

- [Spark 1.6.1](http://spark.apache.org/docs/1.6.1) 
- [Hadoop 2.6.3](http://hadoop.apache.org/docs/r2.6.3)
- [PySpark](http://spark.apache.org/docs/1.6.1/api/python) support with [Anaconda Python2 4.0.0](http://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh).

## simple usage

To build a SciSpark Zeppelin image using the Dockerfile:

```
VERSION=v0.2_001
docker build --rm --force-rm -t pymonger/scispark-zeppelin:${VERSION} -f Dockerfile .
```

To run the built SciSpark Zeppelin image in a container:

```
docker run --rm -p 8080:8080 pymonger/scispark-zeppelin:${VERSION}
```

Zeppelin will be running at `http://${YOUR_DOCKER_HOST}:8080`.

## Advanced usage

Customize the Dockerfile to install data to HDFS or preload notebooks to Zeppelin
and rerun the build instructions above. Remember to increment the VERSION.
