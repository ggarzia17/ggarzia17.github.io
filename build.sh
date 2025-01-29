#!/bin/bash

#get resume file
cp ../../latex/resume/resume.pdf files/

#index
cd src
cat templates/header index.html templates/footer > ../index.html

#Experience
cd experience
echo "building work experience page"        
for file in `ls | sort -k9  -r`; do
    echo "<div class=\"border\">" >> ../../experience.tmp
    cat $file >> ../../experience.tmp
    echo "</div>" >> ../../experience.tmp
done
#projects
cd ../projects
echo "building projects page"        
for file in `ls | sort -k9  -r`; do
    echo "<div class=\"border\">" >> ../../projects.tmp
    cat $file >> ../../projects.tmp
    echo "</div>" >> ../../projects.tmp
done

cd ../../
cat ./src/templates/header projects.tmp ./src/templates/footer > projects.html
cat ./src/templates/header experience.tmp ./src/templates/footer > work.html

rm *.tmp