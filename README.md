大陆白名单路由规则

ip段信息取自 [iwik](https://www.iwik.org/ipcountry/CN.cidr)
由Github Action自动构建于此。

策略路由分流的实现方法：

**CN.rsc** 是往Firewall - address lists 里生成ip段列表。以下是ROS自动更新脚本
```
/file remove [find name="CN.rsc"]
/tool fetch url="https://cdn.jsdelivr.net/gh/ctt727/chnroute@master/CN.rsc"
:if ([:len [/file find name=CN.rsc]] > 0) do={
/ip firewall address-list remove [find comment="AS4809"]
/import CN.rsc
}
```

用于Firewall - mangle页，通过dst-addrss= 引用

生成的 IP 列表在导入时会将所有导入的 IP 注释为 "AS4809", 这是便于使用 ROS 脚本识别删除以达到更新的目的
不使用 list 而用 comment 作为判断条件的原因：使用 IP 列表分流时会添加若干自定义 IP, 如 VPS 地址、Steam 下载地址、不想走代理的内网机等。
更新列表时使用 list 会将上述 IP 一并删除造成使用不便，而 comment 为判断条件很好的避免了这种情况 。
