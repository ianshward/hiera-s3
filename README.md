## Introduction

An S3 backend for [Hiera](https://github.com/puppetlabs/hiera).  Use an S3
bucket to store data for the Hiera hierarchical database.

## Install

`gem install hiera-s3`

## Configure

An example hiera.yaml may look like:

```yaml
---
:backends:
  - s3

:logger: console

:hierarchy:
  - "%{operatingsystem}"
  - common

:s3:
  :key: "MY_AWS_ACCESS_KEY_ID"
  :secret: "MY_AWS_SECRET_KEY"
  :bucket: "my-s3-bucket"
```

Then, create an S3 bucket, such as my-hiera-data. According to the above
configuration, data could then be stored like:

    my-s3-bucket/Ubuntu/example/message

Where Ubuntu will match an Ubuntu host machine, example is the name of a
Puppet module, and message is the name of the variable and is an object in S3.
A "message" S3 object could also live in my-s3-bucket/common/example/message.

From an example Puppet module's init.pp:

```puppet
class example (
    $message = 'Hello, I am the module default'
    ){
    notify { $example::message: }
}
```

Based on the above hiera.yaml configuration, the value in
my-s3-bucket/common/example/message will take priority, followed by the value
in my-s3-bucket/Ubuntu/example/message (if run on an Ubuntu host), followed
by the default value defined in the module itself.

## IAM roles support

If AWS key and secret are not defined in hiera.yaml, the back end will attempt
to use [IAM roles](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UsingIAM.html#UsingIAMrolesWithAmazonEC2Instances).

## Limitations / TODO

- Assumes string variables
- Tests
