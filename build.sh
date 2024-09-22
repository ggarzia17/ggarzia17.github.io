#!/bin/bash

#get resume file
cp ../../latex/resume/resume.pdf .

#index
cd src
cat templates/header index.html templates/footer > ../index.html


# posts
cd posts
echo "building posts"
for file in `ls | sort -k9`; do
    # get title of file and create blog post html file
    title=${file:11:-5}
    cat ../templates/header $file ../templates/footer > ../../$title.html

    # create card in blog.html
    ugly_date=$(stat -c '%w' $file)
    pretty_title=$(echo $title | sed 's/-/ /g')
    pretty_date=${ugly_date:0:19}
    : '
    blog-card template params
    :TITLE:
    :DATE:
    :FILE:
    :DESC:
    '

    description=`cat $file | grep DESC | cut -d "|" -f 2`
    echo "<div class=\"border\">" >> ../../blog.tmp
    cat ../templates/blog-card | sed\
        "s/:TITLE:/$pretty_title/g;\
        s/:FILE:/$title.html/g;\
        s/:DATE:/$pretty_date/g;\
        s/:DESC:/$description/g"\
        >> ../../blog.tmp
    echo "</div>" >> ../../blog.tmp
done

#projects
cd ../projects
echo "building projects"        
for file in `ls | sort -k9  -r`; do
    echo "<div class=\"border\">" >> ../../projects.tmp
    cat $file >> ../../projects.tmp
    echo "</div>" >> ../../projects.tmp
done

cd ../../
cat ./src/templates/header blog.tmp ./src/templates/footer > blog.html
cat ./src/templates/header projects.tmp ./src/templates/footer > projects.html

rm *.tmp