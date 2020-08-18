#! /bin/bash
file="EmptyPage"
# 文档生成
jazzy \
--podspec ../../${file}.podspec \
--output ../../document/ \
--theme fullwidth
