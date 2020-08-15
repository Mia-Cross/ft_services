#!/bin/bash

if [ `which wget` = 'wget not found' ]
then
    #brew casse les couilles, can't do
    brew install wget
fi
wget https://dl1.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2?h=LqVZNLGt8eQ2ShJxEvCr6g&x=1597417863 -O - | tar -xj