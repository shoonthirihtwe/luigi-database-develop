# Luigi2-database

luigi2 database migration files repository.

## 実行環境

flywayをCLI環境にて実行。(Gitlab-CI経由でのpipelineによる自動実行)

  - インフラ担当向け document
    - https://flywaydb.org/documentation/
## migration tool 運用原則
- DDL,DML,ストアドファンクション・プロシージャ等はファイル単位で分離してください。
- 可能な限り細かくクエリをファイル分けされるのが望ましいです（理想はクエリ単位）。
- migrationファイルと同時にUndoファイルを作成してください。
- テストデータの運用方法について検討中です。
- データ操作（DML）はINSERT,DELETEのみとし、UPDATE文は利用しないようにしてください。（クエリの依存関係構築を防ぐ為）
- views/procedures/functions/packages/に関してはバージョン管理対象外とし、Repeatable migration（後述）にて対応を実施してください。
- File名に関して、DescriptionのRenameは可とします。
- File名のVersion名に関して、正常deploy完了後の変更は、不具合修正除き原則不可とします。
## ファイル命名規則

![Flyway naming](https://www.red-gate.com/wp-content/uploads/2020/07/flyway_naming.png "Naming")



- file種別は下記
  - Versioned Migrations: migration SQLのファイル。migrationの基本形です。一度だけ順番に適用されます。
  - Undo Migrations: 切り戻し用SQLファイル。切り戻し対象のVersioned Migrationのversionと一致させる必要あり
  - Repeaable Migrations:バージョン管理対象外ファイル。定義を持つデータベースオブジェクトの管理に有用で、バージョン管理下の単一ファイルで扱えるようになります。基本的には以下のように使います。

    - view/procedure/function/
    - packeageの（再）生成
    - バルクで参照データの再insert


- Versionはsemantic versioningでの命名を行ってください。
- Separatorは__となり、underscoreが2連続するのでご注意ください。
- description中のunderscoreはflywayでのバージョン履歴確認時にspaceに変換されます。
- descriptionにて以下の情報の記載をいただけると助かります。
  - DDL,DML
  - 修正、追加、削除を行ったテーブル名
  - 修正内容（簡易）ex. Add, Update, Delete...

## baseline version

運用開始バージョン。このバージョンより値の小さいバージョンはmigrationの管理対象外となります。

`0.1.0`

## 手順

### 1. migration fileの作成

ファイル命名規則に従い、migration用のSQLクエリファイルを作成する。

1. migration用のtopicブランチの作成
2. `Migration/` 配下にSQLファイルを作成
   1. migration実施対象のdatabase(schema)に対応するディレクトリ内に移動
   2. migration fileを作成。ファイル名は命名規則を参照。中身は純粋なSQL文
   3. Versioned Migrations(適用対象のmigration file),Undo Migrations(切り戻し用のMigration)を作成する
   4. 記載したVersionに基づきクエリが実行される為、クエリの依存関係がある場合は依存関係を考慮したVersionを各migration fileに設定する
3. 作成したMigration,Undoクエリをローカル開発環境で検証し、シンタックスエラー等の問題が無い事を確認する
   
### 2. デプロイ
(一部Optionnal) 開発者間でレビューを行いmigration クエリの品質に問題無い事を確認の上デプロイする

1. 作成したmigration fileに対応するコミットを作成し、topicブランチをpushする
2. developブランチ宛てのMRを作成
3. (Optional)必要に応じてレビュアーを設定しレビューを実施する
4. 問題なければdevelopブランチにMergeする
5. git tagを付与しpushする
6. pipeline経由でdev環境にflywayコンテナがデプロイ、自動migrationが実施される

### 3. 正常性確認

正常にmigrationが適用されているか確認する

1. datadog logsにてmigration実施結果ログを確認する
2. datadog filtering設定(facet)は以下。
   -  kube_app:database-migration
   -  kube_env:dev
   -  kube_project:luigi2
3. エラーが出ている場合、インフラ担当に連絡。正常動作時はインフラ担当へ本番への適用依頼実施
   1. (エラー時)インフラ担当がRepair等利用し一次復旧対応
   2. (エラー時)エラー該当のmigration fileの内容修正、再デプロイ実施
