#!/usr/bin/env bats

@test "-- perms eq 766 -------------------" {}
_perm () {
  local -r var="$1"
  result=$(stat -c "%a %n" "${var}" | cut -d' ' -f1)
  [ "$result" == "766" ]
}

@test "FILE bower-github.json" { _perm /home/vagrant/.config/configstore/bower-github.json ; }
@test "FILE insight-cordova.json" { _perm /home/vagrant/.config/configstore/insight-cordova.json ; }
@test "FILE update-notifier-bower.json" { _perm /home/vagrant/.config/configstore/update-notifier-bower.json ;  }
@test "FILE update-notifier-cordova.json" { _perm /home/vagrant/.config/configstore/update-notifier-cordova.json ;  }
#
@test "FILE /home/vagrant/.cordova" { _perm /home/vagrant/.cordova ;  }
@test "FILE /home/vagrant/.cordova/lib" { _perm /home/vagrant/.cordova/lib;  }

@test "-- user eq $USER -------------------" {}
_user () {
  local -r var="$1"
  result=$(stat -c "%U" "${var}" | cut -d' ' -f1)
  [ "$result" == "$USER" ]
}

@test "FILE bower-github.json" { _user /home/vagrant/.config/configstore/bower-github.json ; }
@test "FILE insight-cordova.json" { _user /home/vagrant/.config/configstore/insight-cordova.json ; }
@test "FILE update-notifier-bower.json" { _user /home/vagrant/.config/configstore/update-notifier-bower.json ;  }
@test "FILE update-notifier-cordova.json" { _user /home/vagrant/.config/configstore/update-notifier-cordova.json ;  }
#
@test "FILE /home/vagrant/.cordova" { _user /home/vagrant/.cordova ;  }
@test "FILE /home/vagrant/.cordova/lib" { _user /home/vagrant/.cordova/lib;  }

@test "-- group eq $GROUP -------------------" {}
_group () {
  local -r var="$1"
  result=$(stat -c "%G" "${var}" | cut -d' ' -f1)
  [ "$result" == "$USER" ]
}

@test "FILE bower-github.json" { _group /home/vagrant/.config/configstore/bower-github.json ; }
@test "FILE insight-cordova.json" { _group /home/vagrant/.config/configstore/insight-cordova.json ; }
@test "FILE update-notifier-bower.json" { _group /home/vagrant/.config/configstore/update-notifier-bower.json ;  }
@test "FILE update-notifier-cordova.json" { _group /home/vagrant/.config/configstore/update-notifier-cordova.json ;  }
#
@test "FILE /home/vagrant/.cordova" { _group /home/vagrant/.cordova ;  }
@test "FILE /home/vagrant/.cordova/lib" { _group /home/vagrant/.cordova/lib;  }

####

# ---- clean up script
#.
#.    # Tweak .config file permissions and ownership
#.    # RUNVAR is vagrant or ubuntu
#.
#.    export RUNVAR=$(pwd | cut -d'/' -f3)
#.    echo ${RUNVAR}
#.
#.      sudo ls -lR /home/${RUNVAR}/.config/.
#.          sudo chown -R ${RUNVAR}:${RUNVAR} /home/${RUNVAR}/.config/.
#.          sudo chmod 766 -R /home/${RUNVAR}/.config/.
#.      sudo ls -lR /home/${RUNVAR}/.config/.
#.
#.      sudo ls -lR /home/${RUNVAR}/.cordova/.
#.          sudo chown -R ${RUNVAR}:${RUNVAR} /home/${RUNVAR}/.cordova/.
#.          sudo chmod 766 -R /home/${RUNVAR}/.cordova/.
#.      sudo ls -lR /home/${RUNVAR}/.cordova/.
#.    #
