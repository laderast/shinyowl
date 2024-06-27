#!/bin/bash
quarto render .
git add docs/.
git commit -m "updating"
git push
