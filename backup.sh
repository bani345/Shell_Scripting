#!/bin/bash

<< readme
this is the script for backup with 5 day rotation

usage:
./backup.sh <path to your source> <path to backup folder>
readme

function display_usage {
    echo "usage: ./backup.sh <path to your source> <path to backup folder>"
}

if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

source_dir=$1
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
backup_dir=$2

function create_backup {
    zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null


    if [ $? -eq 0 ]; then
        echo "backup generated successfully for ${timestamp}"
    else
        echo "backup failed for ${timestamp}"
    fi
}

function perform_rotation {
    backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))

    if [ "${#backups[@]}" -gt 5 ]; then
        echo "Performing rotation for 5 days"

        backups_to_remove=("${backups[@]:5}")

        for backup in "${backups_to_remove[@]}"; do
            rm -f "$backup"
        done
    fi
}

create_backup
perform_rotation

