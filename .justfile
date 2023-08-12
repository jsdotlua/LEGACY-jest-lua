analyze:
    rojo sourcemap default.project.json --output sourcemap.json
    curl -O https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.lua
    luau-lsp analyze --definitions=globalTypes.d.lua --base-luaurc=.luaurc --sourcemap=sourcemap.json --settings=.vscode/settings.json --no-strict-dm-types packages/

# Installs packages and proxies their type information with `wally-package-types` tool
# In addition, the packages/ directory is temporarily renamed so that it isn't removed by Wally
install-packages:
    rm -rf deps/
    mv packages/ temp/

    wally install

    mv Packages deps/
    mv temp/ packages/

    rojo sourcemap default.project.json --output sourcemap.json
    wally-package-types --sourcemap sourcemap.json deps/

    echo "{ \"languageMode\": \"nocheck\" }" > deps/_Index/evaera_promise@4.0.0/promise/.luaurc
