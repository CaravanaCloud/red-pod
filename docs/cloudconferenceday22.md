# Automatizando sua Nuvem com Java

## Amazon Corretto
https://aws.amazon.com/corretto/

```
curl -s "https://get.sdkman.io" | bash
```

```
sdk install java 17.0.3.6.1-amzn
```


## Quarkus + Lambda
https://quarkus.io/guides/amazon-lambda-http

```
sdk install quarkus
```

```
mvn archetype:generate -B \
       -DarchetypeGroupId=io.quarkus \
       -DarchetypeArtifactId=quarkus-amazon-lambda-http-archetype \
       -DarchetypeVersion=2.9.0.Final \
       -DgroupId=caravanacloud \
       -DartifactId=petcare-api \
       -Dversion=0.0.1-SNAPSHOT 
```

```
pushd petcare-api
```

```
mvn quarkus:dev
```

```
quarkus build --native
```

```
sam local start-api --template target/sam.jvm.yaml
```

```
sam deploy -t target/sam.jvm.yaml -g
```



## AWS CDK
https://aws.amazon.com/cdk/

```
mkdir petcare-cdk
pushd petcare-cdk
```

```
cdk init --language java
cdk bootstrap
```

```
cdk deploy --all --require-approval never
```

```
String stamp = ""+System.currentTimeMillis();
Bucket bucket = Bucket.Builder.create(this, "petcare-bucket")
    .bucketName("petcare"+stamp)
    .publicReadAccess(true)
    .build();

ISource src = Source.asset("hello-cdk");

List<ISource> sources = List.of(src);

BucketDeployment deploy = BucketDeployment.Builder.create(this, "petcare-deployments")
    .sources(sources)
    .destinationBucket(bucket)
    .destinationKeyPrefix("hello-cdk/")
    .build();
```

## AWS SDK for Java
https://aws.amazon.com/sdk-for-java/


## Cloud Janitor
https://github.com/CaravanaCloud/cloud-janitor
