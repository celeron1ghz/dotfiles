## INSTALL

```
cd
git clone git@github.com:celeron1ghz/dotfiles.git

cd dotfiles
perl mk_aliases.pl
```

clone後shellを再起動すれば各種セットアップが始まる。

### 自動で入るもの
 * nodeenv
 * plenv

### コマンドがあったら入るもの
 * Poweline (pipenvが存在していた場合)

環境個別の設定は `rc/local.sh` に書くこと。

## VSCode
VSCodeの設定は以下に置くこと。

 * C:\Users\youusername\AppData\Roaming\Code\User
