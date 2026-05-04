# 青龙面板定制镜像 (Qinglong Custom)

## 版本信息

- **自定义版本**: V1.10.0
- **最新版本**: latest
- **基础镜像**: whyour/qinglong:debian

## 功能特性

本镜像基于 `whyour/qinglong:debian` 构建，在原版基础上增强了以下功能：

### 系统依赖

| 依赖 | 说明 |
|------|------|
| ffmpeg | 音视频压缩处理 |
| libgl1-mesa-glx | OpenCV 图形库 |
| libglib2.0-0 | GLib 库 |
| libsm6 | 会话管理库 |
| libxext6 | X11 扩展库 |
| libxrender1 | X Render 库 |
| libgomp1 | GCC OpenMP 支持 |
| fonts-noto-cjk | 中文字体 |
| curl | HTTP 工具 |
| git | 版本控制 |
| inotify-tools | 文件监控 |
| facedetect | 人脸检测 |

### Python 第三方库

| 库名 | 版本要求 | 说明 |
|------|----------|------|
| psutil | >=5.9.0 | 系统资源监控 |
| Pillow | >=10.0.0 | 图片处理 (HEIC/PNG) |
| pyheif | >=0.1.0 | HEIC 格式支持 |
| mutagen | >=1.47.0 | 音频元数据处理 |
| opencc-python-reimplemented | >=0.1.7 | 简繁体转换 |
| zhconv | >=1.2 | 中文繁简转换 |
| python-dateutil | >=2.8.0 | 日期时间处理 |
| chinese-calendar | >=1.9 | 中国节假日 |
| zhdate | >=2.1.0 | 农历日期 |
| pyyaml | >=6.0 | YAML 配置文件读写 |
| requests | >=2.28.0 | HTTP 请求 |
| pymysql | >=1.1.0 | MySQL 数据库连接 |
| cryptography | >=41.0.0 | 加密支持 |
| sqlalchemy | >=2.0.0 | ORM 数据库操作 |
| DBUtils | >=3.0.0 | 数据库连接池 |
| numpy | >=1.24.0 | 数值计算 |
| opencv-python-headless | >=4.5.0 | 图像/视频处理 |
| watchdog | >=6.0.0 | 文件监控 |
| python-dotenv | >=1.2.2 | 环境变量管理 |

## 快速开始

### 使用 Docker Compose

```bash
# 启动容器
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止容器
docker-compose down
```

### 使用 Docker 命令

```bash
# 拉取镜像
docker pull s2662939/qinglong-custom:latest

# 创建数据目录
mkdir -p data logs scripts repo

# 运行容器
docker run -d \
  --name qinglong-custom \
  -p 5700:5700 \
  -v $(pwd)/data:/ql/data \
  -v $(pwd)/logs:/ql/logs \
  -v $(pwd)/scripts:/ql/scripts \
  -v $(pwd)/repo:/ql/repo \
  -e TZ=Asia/Shanghai \
  s2662939/qinglong-custom:latest
```

## 环境变量

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| TZ | Asia/Shanghai | 时区设置 |
| PUID | 1000 | 用户 ID |
| PGID | 1000 | 组 ID |

## 访问

容器启动后，通过浏览器访问: http://localhost:5700

## 构建镜像

```bash
# 构建本地镜像
docker build -t qinglong-custom:local .
```

## 许可协议

本项目基于 MIT 许可证开源。
