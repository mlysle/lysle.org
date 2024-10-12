#!/bin/sh
hugo
npx prettier "./public/**/*.html" --parser html --write
