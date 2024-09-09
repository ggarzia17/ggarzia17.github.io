#!/bin/bash

#get resume file
cp ../../latex/resume/resume.pdf .

#index
cd src
cat templates/header index.html templates/footer > ../index.html


# posts
cd posts

for file in ./*; do
    # get title of file and create blog post html file
    title=${file:2:-5}
    cat ../templates/header $file ../templates/footer > ../../$title.html

    # create card in blog.html
    ugly_date=$(stat -c '%w' $file)
    pretty_title=$(echo $title | sed 's/-/ /')
    pretty_date=${ugly_date:0:19}
    echo "$pretty_date <a href=\"./$file\">$pretty_title</a>" >> ../../blog.tmp
done

cd ../../
cat ./src/templates/header blog.tmp ./src/templates/footer > blog.html

rm blog.tmp