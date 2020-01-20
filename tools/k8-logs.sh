#!/bin/bash

set -u
set -o pipefail

# 查看k8s中容器日志

Program="$0"

usage() {
	cat <<EOF
	$Program resource-name(like podName)
		-c containerName (Required)
		-f stdoutPath(if your log is written to a file, use -f specify it's abs path)
		-- command(like cat, tail -f, vim), default is cat
		-h/--help print this message
	Examples:
		$Program pod xxx -c aaa # show pod xxx container aaa's log from stdout
		$Program deploy yyy -c bbb -f /tmp/b.log # show deploy yyy ALL container bbb's log
			from file /tmp/b.log
EOF
}

usage_exit() {
	usage
	exit 1
}

# $Program podName -c xxx, at least 3 args
if [[ $# -lt 3 ]]; then
	usage_exit
fi

DefaultCommand="cat"

resourceName="$1"
containerName=''
stdoutPath=''
command4log=''
interactively=0 # 命令是否是交互式的, 如tail -f这种的
_datetime=$(date +'%Y%m%d%H%M%S')
tmpLogFile="/tmp/$resourceName-$_datetime.log"
tmpPidFile="/tmp/$resourceName-$_datetime.pid"

rm -f "$tmpLogFile" "$tmpPidFile"

# 跳过resourceName
shift 1

# 解析剩下的参数
while [ $# -ne 0 ]; do
case "$1" in
	-c)
		containerName="$2"
		shift 2
	;;
	-f)
		stdoutPath="$2"
		shift 2
	;;
	--)
		# -- 后面全是命令及其参数, 解析完直接退出
		shift 1
		if [ $# -eq 0 ]; then # -- 后面没有了
			usage_exit
		fi
		command4log="$*"
		break
	;;
	-h|--help)
		usage_exit
	;;
	*)
		echo "Unsupported options: $1" >&2
		usage_exit
	;;
esac
done

command4log=${command4log:-$DefaultCommand}

echo "$command4log" | grep tail | grep -q -- -f
if [ $? -eq 0 ]; then # 如果是 tail -f
	interactively=1
fi

allPods=($(kubectl get po | grep ^"$resourceName" | awk '{print $1}'))
if [ "${#allPods[@]}" -eq 0 ]; then
	echo "pod with prefix $resourceName not found" >&2
	exit
fi

main() {
	# 没有stdoutPath 说日志是重定向到文件的
	if [ x"$stdoutPath" = x ]; then
		# 不是交互式, 直接输出
		if [ $interactively -eq 0 ]; then
			for p in $allPods; do
				kubectl logs "$p" -c "$containerName" >>$tmpLogFile 2>&1
			done
		else
			for p in $allPods; do
				nohup kubectl logs "$p" -f -c "$containerName" >> $tmpLogFile 2>&1 &
				echo $! >> $tmpPidFile
			done
		fi
	else
		if [ $interactively -eq 0 ]; then
			for p in $allPods; do
				kubectl exec -it "$p" -c "$containerName" -- cat $stdoutPath >>$tmpLogFile 2>&1
			done
		else
			for p in $allPods; do
				nohup kubectl exec -it "$p" -c "$containerName" -- tail -f $stdoutPath >> $tmpLogFile 2>&1 &
				echo $! >> $tmpPidFile
			done
		fi
	fi
	exec $command4log $tmpLogFile
}

main
