#!/bin/bash
#Generates and posts the tar file to the gh-pages branch, for use w/ Travis-ci

if [ "$TRAVIS_REPO_SLUG" == "aaronjeline/podlators" ] &&  [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then
  echo -e "Building doc... \n"
  cd 
  tar czf podlators
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/aaronjeline/podlators gh-pages > /dev/null
  cd gh-pages
  git rm podlators.tar.gz
  cp ../podlators.tar.gz ./
  git add -f .
  git commit -m "Latest tar on build $TRAVIS_BUILD_NUMBER"
  git push -fq origin gh-pages > /dev/null

  echo -e "Published to gh-pages \n"

fi
