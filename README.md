# Jorge's Notes on using BATS 
source: (https://github.com/sstephenson/bats)

### At its simplest, a bats test might just be;
	@test "Check that the mysql client is available" {
	    command -v mysql
	}

or alternativly 

	@test "Check that we have a /tmp directory" {
	    run stat /tmp
	    [ $status = 0 ]
	}

### A more complex solutions call to encapsulate the entire command being 
  tested as a bash -c inline string:

@test "Test that we get the word 'bar'" {
    run bash -c "echo 'foo bar baz' | cut -d' ' -f2"
    [ "$output" = "bar" ]
}

I find the '**run**' syntax does not work for me, so I this method

	@test "Test for perms values set 766" {
	  result=$(stat -c "%a %n" /home/vagrant/.config/configstore/bower-github.json | cut -d' ' -f1)
	  [ "$result" != "766" ]
	}

### also, if this is true
	@test "test for equality" {
	  A=1
	  B=1
	  [ "$A" -eq "$B" ]
	}

### then this should follow to test for ENV variables are set
	@test "Test for $HOME values set" {
	  [ "$HOME" -eq "/home/vagrant" ]
	}
	
	@test "Test for $JAVAHOME values set" {
	  [ "$JAVAHOME" -eq "/usr/lib/jvm/java-8-oracle" ]
	}
	
	@test "Test for $ANDROID_HOME values set" {
	  [ "$ANDROID_HOME" -eq "~/android-sdk-linux" ]
	}

![pic](https://www.dropbox.com/s/t3keoh0phfop25v/bats-checks.png?raw=1)

----
### Various Methods for checking files

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

---
### And using a quasi loop

	loop_perms() {
	  local -r var="$1"
	  result=$(gstat -c "%a %n" "${var}" | cut -d' ' -f1)
	  [ "$result" == "644" ]
	}
	
	@test "test Vagrantfile" {
	  helper /Users/jld0517/play/vbox-postgui/Vagrantfile
	}
	
	@test "test v_bootstrap.sh" {
	  helper /Users/jld0517/play/vbox-postgui/v_bootstrap.sh
	}
	
	@test "test v_bootstrap.sh" {
	  helper /Users/jld0517/play/vbox-postgui/v_startup.sh
	}
	
	@test "Test for ownership values NOT set $USER" {
	  result=$(stat -c %U /home/vagrant/.config/configstore/bower-github.json)
	  [ "$result" != "$USER" ]
	}
	
and even more developed loop

