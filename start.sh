#!/bin/sh

help ()
{
    echo  ' ================================================================ '
    echo  ' --ansible-images: 离线环境下指定 ansible 镜像，同步镜像 registry.cn-shanghai.aliyuncs.com/rancher/ansible 到私有仓库'
    echo  ' --tags: 通过tags指定步骤运行'
    echo  ' --host-groups: 指定主机组运行，默认使用主机组 all'
    echo  ' --log-level: -vvv 输出详细日志，-vvvv 进入 debug 模式'
    echo  ' ================================================================'
}

case "$1" in
    -h|--help|help) help; exit;;
esac

CMDOPTS="$*"
for OPTS in $CMDOPTS;
do
    KEY=$(echo ${OPTS} | awk -F"=" '{print $1}' )
    VALUE=$(echo ${OPTS} | awk -F"=" '{print $2$3$4$5}' )
    case "$KEY" in
        --ansible-images) ANSIBLE_IMAGES=${VALUE} ;;
        --tags) TAGS=${VALUE} ;;
        --log-level|-V) LOG_LEVEL=${VALUE} ;;
    esac
done

DIR_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

touch cache/history.log
echo " $(date +"%Y-%m-%d-%H:%M:%S") $(basename $0) $* " >> cache/history.log

# 给脚本执行权限
ANSIBLE_IMAGES=${ANSIBLE_IMAGES:-registry.cn-shanghai.aliyuncs.com/rancher/ansible}
HOSTS=${HOSTS:-hosts.yaml}
TAGS=${TAGS}
LOG_LEVEL=${LOG_LEVEL}
CUSTOM_HOST_GROUPS=${CUSTOM_HOST_GROUPS}

docker run --rm -ti \
-v ${DIR_ROOT}:/etc/ansible \
${ANSIBLE_IMAGES} \
ansible-playbook ${LOG_LEVEL} ./roles/all.yaml --extra-vars "host_groups=${CUSTOM_HOST_GROUPS}" `if [[ -n $TAGS ]]; then echo "--tags=${TAGS}"; fi`;
