# branch-note.vim

ブランチごとにメモを取ることができます。メモは下記のファイル構成で管理されるので整理する必要がありません。カレントブランチに対応したファイルを自動で開きます。ブランチごとにメモ用、 pullrequest用、issue用のテキストを残すことができます。

ファイル構成は下記のとおりです。

```
$HOME/
  branchnote/
    github/
      user_name/
        repogitory_name/
          master/
            note.md
          topic_branch1/
            note.md
            pullrequest.md
            issue.md
          topic_branch2/
    .template/
      note-default-template.md
      issue-defaullt-template.txt
```

* リポジトリとは別ディレクトリで管理されるので、トラッキングする必要はありません。
* `git clean -f`を実行してもメモが消えることはありません。
* 同じリポジトリを複数cloneしても、1つの共通のメモを開くことができます。

## テンプレート

下記のように設定値で各ファイル名ごとにデフォルトのテンプレートファイルを指定することができます。dictのkeyでファイル名、valueで`.template`以下のファイルパスを指定します。テンプレートはファイルを新規作成する時のみ挿入されます。

```
let g:branchnote_global_template_each_type = {'note': 'note-template.md', 'issue': 'issue-template.txt'}
```

## コマンド

ファイル名は引数で決めることが出来ます。

```
" カレントブランチのための指定したテキストファイルを開きます
" 新規の場合は自分で保存しなければ、ファイルは残りません。
" arg1: 保存するファイルのベースネーム
command! -nargs=? BNoteOpen :call branchnote#open(<args>)
```

## オプション

下記の代入値はデフォルト値です。

```
" テキストファイルを保存するパス
let g:branchnote_path = $HOME . "/branchnote/"

" 保存するファイルの拡張子
let g:branchnote_note_suffix = "md"


" ファイル名ごとのテンプレートファイルパス
" ex: {'note': 'note-template.md', 'issue': 'issue-template.txt'}
let g:branchnote_global_template_each_type = {}
```

## MAP

```
" カレントブランチのための、note.md, issue.md, pullrequest.mdを開きます。
nnoremap <Space>bb :<C-u>BNoteOpen('note')<CR>
nnoremap <Space>bi :<C-u>BNoteOpen('issue')<CR>
nnoremap <Space>bp :<C-u>BNoteOpen('pullrequest')<CR>
```

## 追加予定の機能

* Githubに投稿
* テンプレート機能
* 既に別タブで開いている場合は移動する
* 開き方を新規タブ・現在のウィンドウかを選択可能
