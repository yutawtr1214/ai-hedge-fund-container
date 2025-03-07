# ベースイメージとしてPython 3.9を使用
FROM python:3.11-slim

# 必要なシステムパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# Poetryをインストール
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Poetry設定:仮想環境をプロジェクト内に作成しない
RUN poetry config virtualenvs.create false

# 依存関係ファイルをコピー
COPY pyproject.toml poetry.lock* ./

# 依存関係をインストール
RUN poetry install --no-interaction --no-ansi --no-root

# エントリポイントの設定
ENTRYPOINT ["poetry", "run", "python"]
CMD ["src/main.py", "--ticker", "AAPL,MSFT,NVDA"]