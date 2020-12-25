# 使用说明

> 注意：此工具目前处于测试阶段

## 版本定义

在 hosts.yaml 文件的 `rke2.version` 处定义版本号

## rke2 二进制文件下载

因为 GitHub 文件大小限制，无法上传超过 100M 的文件。

在操作前去 `https://github.com/rancher/rke2/releases` 下载 rke2 二进制文件保存到 bin 目录下，并以 `rke2.版本号.linux-amd64` 的方式命名，例如: `rke2.v1.18.12+rke2r2.linux-amd64`。

## 离线安装

对于离线安装，下载 rke2-images.linux-amd64.tar.gz 文件到 bin 目录，然后重命名为 `rke2-images.版本号.linux-amd64.tar.gz`，例如：`rke2-images.v1.18.12+rke2r2.linux-amd64.tar.gz`。

## 操作类型

在 hosts.yaml 文件的 `rke2.operation_type` 处定义操作类型，install、upgrade、add-master-node、add-agent-node、remove-node、uninstall、none
