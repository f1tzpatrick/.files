#!/usr/bin/env bash

parallelize() {
	tasks=$1
	pid_array=() # Track backgrounded pids
	for task in $tasks; do
		printf "running %s " "$task"
		eval "$task" &
		pid_array+=($!)
	done
	# Wait for pid completion
	for pid in "${pid_array[@]}"; do
		wait "${pid}" &>/dev/null
	done
}

