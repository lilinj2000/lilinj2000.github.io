#! /bin/sh

/c/Windows/System32/chcp.com 65001

rake generate

/c/Windows/System32/chcp.com 936

rake preview

