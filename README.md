
# 

## 

```bash
# 本番用にビルド
dotnet publish -p:PublishSingleFile=true --self-contained --configuration Release

-r linux-x64

# Gentoo, aplineなどただ動かない。
-r linux-musl-x64
# windows11 or windows10
-r win10-x86
# macos montrey
-r osx.12-x64

```
