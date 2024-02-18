#!/bin/bash

echo "alias dirsize='du -sh'" >> ~/.bashrc

echo 'alias clears="clear ; ls"' >> ~/.bashrc

echo '
function cd(){
	command cd "$@" && clears;
}
' >> ~/.bashrc
