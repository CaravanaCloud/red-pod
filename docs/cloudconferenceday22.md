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

//TODO: curl
//TODo: package
//TODO: deploy

## AWS CDK
https://aws.amazon.com/cdk/

```
mkdir petcare
pushd petcare
```

```
cdk init --language java
cdk bootstrap
```

```
cdk deploy --all --require-approval never
```



```
popd
```

## AWS SDK for Java
https://aws.amazon.com/sdk-for-java/

//TODO: Cloud Janitor