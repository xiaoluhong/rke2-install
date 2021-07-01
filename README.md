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

## 几个重要的配置点

- all.rke2.operation_type: 可选类型: install、upgrade、add-master-node、add-agent-node、remove-node、uninstall、none
  - install: 更新配置安装 rke2 。
  - upgrade: 滚动更新每个节点。
  - add-master-node: 需要在添加的 master 节点上添加 add_node: true
  - add-agent-node: 需要在添加的 master 节点上添加 add_node: true
  - remove-node: 需要在添加的 master 节点上添加 remove_node: true
  - uninstall: 清理整合集群和节点残留（数据会全部丢失）

- all.rke2.version: 定义需要安装或者升级的 rke2 版本号.
- all.rke2.server.url: 用于 Agent 连接 Master 的 ip 或者域名，如果是 HA 模式，此地址应该为 master 前面的 VIP 地址。此配置只能设置一个地址。9345 端口不能修改
- all.rke2.server.url_tls_san: 因为 ssl 证书中会绑定 ip 或者域名，只有通过绑定的地址才可以访问。如果后期想更换另一个地址访问，则可以在此添加。此配置可以设置多个地址。
- all.rke2.token: ha 模式下认证 token，可自行生成随机字符串。
- all.system_default_registry: 对于离线环境，可以指定私有镜像仓库地址。
- all.registry: 对于镜像仓库需要认证才能访问的，这里可以配置认证信息。

################### 主机 配置参数说明 ###################

```bash
# advertise_address: apiserver 用于向集群成员发布消息的通告地址，默认与 node-external-ip/node-ip 相同，一般不用配置。
# node_external_ip: 节点公网 ip。
# node_name: 节点名称。
# role: 定义 K8S 集群节点角色，master 或者 agent。
# node_label: 节点标签，数组形式，例如：- test: true
# node_taint: 节点污点，数组形式，例如：- "CriticalAddonsOnly: true:NoExecute"
# add_node: true/false，新的节点设置为 true，将会自动添加到集群。
# remove_node: true，如果要删除某个节点，在节点中定义 remove 为 true。

####### 主机 K8S 组件参数 #######
# hosts_kubelet_arg: kubelet 扩展参数，agent 和 master 均支持。
# hosts_kube_proxy_arg: kube-poryx 扩展参数，agent 和 master 均支持。
# hosts_kube_scheduler_arg: kube-scheduler 扩展参数，仅 master 节点支持。
# hosts_kube_apiserver_arg: kube-apiserver 扩展参数，仅 master 节点支持。
# hosts_kube_controller_manager_arg: kube-controller_manager 扩展参数，仅 master 节点支持。

####### 主机 ssh 连接配置信息 #######
# ansible_ssh_port: ssh 端口
# ansible_user: ansible ssh 用户
# ansible_ssh_pass: ansible ssh 用户密码
# ansible_become_pass: sudo 权限密码。如果 sudo 没有配置免密，则需要设置此密码
# ansible_ssh_private_key: 如果节点使用 ssh key 认证登录，需要将 ssh key 存放在 ssh-key/ 目录下，配置格式为 ansible_ssh_private_key=ssh-key/xxxx-key
```
