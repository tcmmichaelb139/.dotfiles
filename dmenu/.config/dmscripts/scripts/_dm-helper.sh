#!/usr/bin/env bash

# Script name: _dm-helper
# Description: helper-script for the other scripts in the collection
# Dependencies:
# GitLab: https://www.gitlab.com/dwt1/dmscripts
# License: https://www.gitlab.com/dwt1/dmscripts/LICENSE
# Contributors: Simon Ingelsson

set -euo pipefail

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This is a helper-script it does not do anything on its own."
    exit 1
fi

get_local_config() {
  # Do some subshell magic finding out where the script we are running 
  # is located and checking if ../config is a dir relative to the script
  echo "$(
    cd "$(dirname "$(readlink "${BASH_SOURCE[0]}" || echo ".")")./"
    if [[ -d "${PWD}/config" ]]; then
      echo "${PWD}/config"
    fi
  )"
}



get_config() {
  local _config_files=()
  local _local_conf
  _local_conf="$(get_local_config)"

  # add User config path
  _config_files+=( "${HOME}/.config/dmscripts/config" )

  # Add git-repo relative config path (if exits)
  [[ -f "${_local_conf}/config" ]] && _config_files+=( "${_local_conf}/config" )

  # Add global installed config path
  _config_files+=( "/etc/dmscripts/config" )

  for conf in "${_config_files[@]}"; do
    if [[ -f ${conf} ]]; then
      echo "${conf}"
      return
      break
    fi
  done
}

# Check if config has updates that should be displayed to the user
check_updated_config() {
  local _base_file
  local _config_file
  _base_file=-1
  [[ -f /etc/dmscripts/config ]] && _base_file="/etc/dmscripts/config"
  _local_conf="$(get_local_config)"
  [[ -f "${_local_conf}/config" ]] && _base_file=${_local_conf}/config
  _config_file=$(get_config)

  [[ "${_config_file}" == "${_base_file}" ]] && return

  _config_file_revision=$(grep "^_revision=" "${_config_file}")
  _base_file_revision=$(grep "^_revision=" "${_base_file}")

  if [[ ! "${_config_file_revision}" == "${_base_file_revision}" ]] ; then
    diff -y "${_config_file}" "${_base_file}" | less
    echo  "${_config_file}  > ${_base_file}"
    echo  "New revision of the configuration detected, please review and set ${_base_file_revision} in ${_config_file} when done"
  fi
}

# Simple warn function
warn () {
  printf 'Warn: %s\n' "$1"
}

# Simple error function
err () { 
  printf 'Error: %s\n' "$1"
  exit 1
}

xmlgetnext () {
  local IFS='>'
  # we need to mangle backslashes for this to work
  # shellcheck disable=SC2162
  read -d '<' TAG VALUE
}

parse_rss() {
  echo "$1" | while xmlgetnext ; do
    case $TAG in
        'entry')
          title=''
          link=''
          published=''
          ;;
        'media:title')
          title="$VALUE"
          ;;
        'yt:videoId')
          link="$VALUE"
          ;;
        'published')
          published="$(date --date="${VALUE}" "+%Y-%m-%d %H:%M")"
            ;;
        '/entry')
          echo " ${published} | ${link} | ${title}"
          ;;
        esac
  done
}
