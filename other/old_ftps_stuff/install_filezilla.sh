#!/bin/bash

if [[ `which wget` = 'wget not found' ]]
then
    #brew casse les couilles, can't do
    brew install wget
fi
curl https://dl1.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2?h=LqVZNLGt8eQ2ShJxEvCr6g&x=1597417863 | tar -xjf



    #    echo "1"
    #    curl 'https://dl4.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2?h=nLvUmM7xpPH0QNkLmpVnAQ&x=1597587470' | tar -xj
    #    echo "2"
    #    curl "https://dl4.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2?h=nLvUmM7xpPH0QNkLmpVnAQ&x=1597587470" | tar -xj
    #    echo "3"
    #    curl https://dl4.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2?h=nLvUmM7xpPH0QNkLmpVnAQ&x=1597587470 | tar -xj
    #    echo "4"
    #    curl 'https://dl4.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2\?h\=nLvUmM7xpPH0QNkLmpVnAQ\&x\=1597587470' | tar -xj
    #    echo "5"
    #    curl "https://dl4.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2\?h\=nLvUmM7xpPH0QNkLmpVnAQ\&x\=1597587470" | tar -xj
    #    echo "6"
    #    curl https://dl4.cdn.filezilla-project.org/client/FileZilla_3.49.1_macosx-x86.app.tar.bz2\?h\=nLvUmM7xpPH0QNkLmpVnAQ\&x\=1597587470 | tar -xj
    #    echo "7"