# Docker環境でのAI Hedge Fund実行手順

このプロジェクトをDocker環境で実行するための手順です。

## 前提条件

- Dockerがインストールされていること
- Docker Composeがインストールされていること

## セットアップ手順

1. **環境変数の設定**

   `.env`ファイルをプロジェクトのルートディレクトリに作成し、必要なAPIキーを設定します。

   ```bash
   # .envファイルの例
   OPENAI_API_KEY=your-openai-api-key
   # 他のAPIキーが必要であれば追加
   ```

2. **Docker環境の起動**

   ```bash
   docker-compose up -d
   ```

3. **Docker コンテナに接続**

   ```bash
   docker-compose exec ai-hedge-fund bash
   ```

   これにより、コンテナ内のシェルに接続されます。

4. **アプリケーションの実行**

   コンテナ内で以下のコマンドを実行します。

   ```bash
   # ヘッジファンドの実行
   python src/main.py --ticker AAPL,MSFT,NVDA

   # バックテスターの実行
   python src/backtester.py --ticker AAPL,MSFT,NVDA
   ```

## オプション

### 単一コマンドでの実行

コンテナに接続せずに直接コマンドを実行することもできます。

```bash
docker-compose run --rm ai-hedge-fund src/main.py --ticker AAPL,MSFT,NVDA --show-reasoning
```

### Dockerfileのカスタマイズ

必要に応じて`Dockerfile`をカスタマイズすることができます。例えば、異なるPythonバージョンを使用する場合は、ベースイメージを変更します。

## トラブルシューティング

### 依存関係の問題

Poetry関連のエラーが発生した場合：

```bash
docker-compose exec ai-hedge-fund poetry install
```

### ボリュームマウントの問題

ファイルが正しくマウントされていない場合は、Docker Composeを再起動してください：

```bash
docker-compose down
docker-compose up -d