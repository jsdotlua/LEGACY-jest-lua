# Installs packages and proxies their type information with `wally-package-types` tool
# In addition, the packages/ directory is temporarily renamed so that it isn't removed by Wally
install-packages:
    mv packages/ temp/

    wally install
    
    mv Packages deps/
    mv temp/ packages/

    rojo sourcemap default.project.json --output sourcemap.json
    wally-package-types --sourcemap sourcemap.json Packages/
