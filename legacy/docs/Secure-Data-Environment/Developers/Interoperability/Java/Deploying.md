---
title: Java Deployments
layout: page
nav_exclude: true
---

# Java Deployments
For now deployments in java are carried out manually, this is because a requirement of central repository is that the libraries are signed using GPG

## JDK
As a number of the applications we are developing for specifically are still using JDK 8, we are currently developing on JDK 8 as well.

## Apache Maven
Our [java libraries](../Java.md) tend to utilise Apache Maven to deploy libaries and package up deployments.

### Installing on Windows
Download the zip file:
https://maven.apache.org/install.html

Extract the files in zip file to a new directory

In the directory should now be a folder called something like:

```
apache-maven-3.9.6
```

copy that folder to:
```
C:\Program Files\
```

Which should leave you a folder like:
```
C:\Program Files\apache-maven-3.9.6
```

Take a note of the folders full path and add this into the **System Environment Variables** in an entry called **MAVEN_HOME**. In the **Path** add in the entry:

```
%MAVEN_HOME\bin
```

You can then test this by opening a new command prompt window and running the following command:

```
mvn --version
```

This should give you a response similar to the following:
```
Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: C:\Program Files\apache-maven-3.9.6
Java version: 1.8.0_302, vendor: Temurin, runtime: C:\Program Files\Eclipse Foundation\jdk-8.0.302.8-hotspot\jre
Default locale: en_GB, platform encoding: Cp1252
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
```

### Installing on Ubuntu
Run the following command
```bash
sudo apt-get install maven
```

## GPG
Download and Install GPG using the instructions on their website:
https://gnupg.org/download/

Once installed, start a new command prompt and enter the following command
```
gpg --gen-key
```

Follow the on screen instructions and you should be presented with something that looks like the following

```
public and secret key created and signed.

pub   ed25519 2024-05-03 [SC] [expires: 2027-05-03]
      8E696024CEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
uid                      Joe Bloggs <Joe.Bloggs@nhs.net>
sub   cv25519 2024-05-03 [E] [expires: 2027-05-03]
```

From this you can see a thumbprint for the key you've created, you'll need to take a note of this thumbprint and use it in the following command:

```
gpg --keyserver keyserver.ubuntu.com --send-keys 8E696024CEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```

subsituting out the thumbprint for your own thumbprint. This should give you an output similar to this:
```
gpg: sending key E5BAAAAAAAAAAAAAA to hkp://keyserver.ubuntu.com
```

This will register you on the ubuntu keyserver.

## Central Repository
In order to allow you to deploy libraries onto the central repository managed by sonatype, you will need to [create an account with the central repository](https://central.sonatype.com/). **It is important that you use the same email address as on the gpg certificate above**. 

Once you have an account you will need to register against the namespace: 

```
io.github.lsc-sde
```

You may need to have a repository in github created in order to verify that you're allowed to upload for our organisation. If you have the permissions you can do this yourself, or do it for someone else.

Once you have gotten setup you can create a token from the portal and update your settings, example below:

```xml example settings.xml
<settings>
  <servers>
    <server>
      <id>central</id>
      <username>YOUR CENTRAL REPOSITORY USERNAME</username>
      <password>YOUR CENTRAL REPOSITORY TOKEN</password>
    </server>
  </servers>
  <profiles>
    <profile>
      <id>nhs</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <gpg.executable>gpg</gpg.executable>
        <gpg.passphrase>Your GPG passphrase</gpg.passphrase>
      </properties>
    </profile>
  </profiles>
</settings>
```
Once this is done you should be able to:
* increment the version number in the pom.xml file of the package you're building
* deploy the package using the command:
```
mvn clean deploy
```