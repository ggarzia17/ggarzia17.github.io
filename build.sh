#!/bin/bash

#get resume file
cp ../../latex/resume/resume.pdf .

#index
cd src
cat templates/header index.html templates/footer > ../index.html


# posts
cd posts

for file in `ls | sort -k9`; do
    # get title of file and create blog post html file
    title=${file:11:-5}
    cat ../templates/header $file ../templates/footer > ../../$title.html

    # create card in blog.html
    ugly_date=$(stat -c '%w' $file)
    pretty_title=$(echo $title | sed 's/-/ /')
    pretty_date=${ugly_date:0:19}
    echo "$pretty_date <a href=\"./$file\">$pretty_title</a>" >> ../../blog.tmp
done

cd ../projects
for file in `ls | sort -k9  -r`; do
    cat $file >> ../../projects.tmp
done

cd ../../
cat ./src/templates/header blog.tmp ./src/templates/footer > blog.html
cat ./src/templates/header projects.tmp ./src/templates/footer > projects.html

rm *.tmp