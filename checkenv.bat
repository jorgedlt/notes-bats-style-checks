### #!/usr/bin/env bats

#
#### unit test for - installed components [ node, npm, gulp, bower & java* ]
#

#### jorge.delatorre@sbdinc.com - 2016-06-23
#### requires - https://github.com/sstephenson/bats

@test "--UTILS versions -------------------" {}

@test "check installed NODE version = v6.3.1" {
  result="$(node -v)"
  [ "$result" = 'v6.3.1' ]
}

@test "check installed NODEJS version = v0.10.25" {
  result="$(nodejs --version)"
  [ "$result" = 'v0.10.25' ]
}

@test "check installed N version = v2.1.3" {
  result="$(sudo n --version)"
  [ "$result" = '2.1.3' ]
}

@test "check installed NPM version = v3.10.3" {
  result="$(npm -v)"
  [ "$result" = '3.10.3' ]
}

@test "check installed GULP version = v3.9.1" {
  result="$(gulp -v | head -1 | awk '{print $4}')"
  [ "$result" = '3.9.1' ]
}

@test "check installed BOWER version = v1.7.9" {
  result="$(sudo bower -version)"
  [ "$result" = '1.7.9' ]
}

@test "check installed CORDOVA version = v6.3.0" {
  result="$(sudo cordova -v)"
  [ "$result" = '6.3.0' ]
}

#
# NOTE: java and javac output version in nonstandard way
# and require additional handling, so a tmp file
# was used.
#

@test "check installed JAVA version = v1.8.0_101" {
  java -version &> /tmp/testfile.out
  result="$(cat /tmp/testfile.out | head -1 | awk '{print $3}' | tr -d '"')"
  rm -rf /tmp/testfile.out

  [ "$result" = '1.8.0_101' ]
}

@test "check installed JAVAC version = v1.8.0_101" {
  javac -version &> /tmp/testfile.out
  result="$(cat /tmp/testfile.out | head -1 | awk '{print $2}' | tr -d '"')"
  rm -rf /tmp/testfile.out

  [ "$result" = '1.8.0_101' ]
}
#

@test "-- ENV Setup -------------------" {}

@test "Test for $HOME values set" {
  [ "$HOME" = "/home/vagrant" ]
}

@test "Test for $JAVAHOME values set" {
  [ "$JAVAHOME" = "/usr/lib/jvm/java-8-oracle" ]
}

@test "Test for $ANDROID_HOME values set" {
  [ "$ANDROID_HOME" = "/home/vagrant/android-sdk-linux" ]
}

@test "-- Files -------------------" {}

@test "Test for ownership values NOT set $USER" {
  result=$(stat -c %U /home/vagrant/.config/configstore/bower-github.json)
  [ "$result" != "$USER" ]
}

@test "Test for group values NOT set $USER" {
  result=$(stat -c %G /home/vagrant/.config/configstore/bower-github.json)
  [ "$result" != "$USER" ]
}

@test "Test for perms values set 766" {
  result=$(stat -c "%a %n" /home/vagrant/.config/configstore/bower-github.json | cut -d' ' -f1)
  [ "$result" != "766" ]
}

#
