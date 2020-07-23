Ansible deploy Hyper-Converged Server
==========

1、裸机初始化
-----------------
1.ansible master节点的public key添加到裸机<br>

2.裸机系统的一些配置<br>
    * Add public key to each other<br>
    * disable selinux<br>
    * stop and disable iptables<br>
    * setup hostname<br>
    * config ip addr<br>
    * config repo<br>

2、控制节点裸机初始化
---------------------
1.创建本地mirrors<br>

2.安装database服务<br>

3.安装NTP server和NTP client(所有裸机需要配置客户端)<br>


3、远程节点裸机服务部署
-------------------------------------------------
1.部署存储节点，安装ceph<br>

2.部署计算节点，安装kvm-qemu、libvirt-\*<br>

3.部署监控节点，安装prometheus<br>

4.部署控制节点，安装catkeeper<br>

5.部署前端节点，安装UI<br>

6.部署后的验证、测试(此项待定)<br>

4、Usage
--------
1.把converge-mirros.tar.gz文件放到/opt目录下<br>

2.把待部署裸机ip写入hosts文件<br>

3.运行ansible-playbook:  ansible-playbook -i hosts site.yml -v <br>
