# ============================================================
# 青龙面板定制镜像 - V1.10.0
# 基础镜像: whyour/qinglong:debian
# ============================================================

FROM whyour/qinglong:debian

# ============================================================
# 版本标识
# ============================================================
LABEL maintainer="Custom" \
      version="V1.10.0" \
      description="青龙面板定制镜像 - 增强版" 

# ============================================================
# 防止交互式安装提示
# ============================================================
ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ=Asia/Shanghai \
    LANG=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    BASE_MOUNT_POINT=/source

# ============================================================
# 安装系统依赖 (Debian/Ubuntu)
# ============================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    # 音视频处理
    ffmpeg \
    # OpenCV 图形库依赖
    libgl1-mesa-glx \
    # GLib 库
    libglib2.0-0 \
    # 会话管理库
    libsm6 \
    # X11 扩展库
    libxext6 \
    # X Render 库
    libxrender1 \
    # GCC OpenMP 支持
    libgomp1 \
    # 中文字体
    fonts-noto-cjk \
    # HTTP 工具
    curl \
    # 版本控制
    git \
    # 文件监控
    inotify-tools \
    # 人脸检测
    facedetect \
    # Python 编译依赖
    python3-dev \
    python3-pip \
    build-essential \
    libpq-dev \
    # 其他必要工具
    wget \
    unzip \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# 设置中文字体缓存
# ============================================================
RUN fc-cache -fv && fc-list :lang=zh

# ============================================================
# 升级 pip 和 setuptools
# ============================================================
RUN pip3 install --upgrade pip setuptools wheel

# ============================================================
# 安装 Python 第三方依赖
# ============================================================
RUN pip3 install --no-cache-dir \
    # 系统资源监控
    psutil>=5.9.0 \
    # 图片处理 (HEIC/PNG)
    Pillow>=10.0.0 \
    # HEIC 格式支持
    pyheif>=0.1.0 \
    # 音频元数据处理
    mutagen>=1.47.0 \
    # 简繁体转换
    opencc-python-reimplemented>=0.1.7 \
    # 中文繁简转换
    zhconv>=1.2 \
    # 日期时间处理
    python-dateutil>=2.8.0 \
    # 中国节假日
    chinese-calendar>=1.9 \
    # 农历日期
    zhdate>=2.1.0 \
    # YAML 配置文件读写
    pyyaml>=6.0 \
    # HTTP 请求
    requests>=2.28.0 \
    # MySQL 数据库连接
    pymysql>=1.1.0 \
    # 加密支持
    cryptography>=41.0.0 \
    # ORM 数据库操作
    sqlalchemy>=2.0.0 \
    # 数据库连接池
    DBUtils>=3.0.0 \
    # 数值计算
    numpy>=1.24.0 \
    # 图像/视频处理
    opencv-python-headless>=4.5.0 \
    # 文件监控
    watchdog>=6.0.0 \
    # 环境变量管理
    python-dotenv>=1.2.2

# ============================================================
# 清理 pip 缓存
# ============================================================
RUN rm -rf /root/.cache/pip

# ============================================================
# 工作目录
# ============================================================
WORKDIR /ql

# ============================================================
# 健康检查
# ============================================================
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5700/ || exit 1

# ============================================================
# 默认启动命令
# ============================================================
CMD ["python3", "-m", "qinglong"]
