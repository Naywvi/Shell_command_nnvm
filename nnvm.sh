#!/bin/bash

	#elemnt verification
	firstElem=$1
	secondElem=$2
	thirdElem=$3
	fourthElem=$4

nnvmConstructor(){
#>bye
	if [ $firstElem = "-bye" ] 2>/dev/null ; then
		#Send delete files
		echo "[x] - bye, delete all files."
		echo rm /usr/bin/nnvm
		return
#<bye

#>ip
	elif [ $firstElem = "-ip" ] 2>/dev/null ;then
		if [ $firstElem = '-ip' ] 2>/dev/null && [ $secondElem != '' ] 2>/dev/null && [ -z "$thirdElem"] 2>/dev/null && [ -z "$fourthElem"] 2>/dev/null ; then
			echo `dpkg-query -l resolvconf`
			if [ $? = "1" ] 2>/dev/null
			then
				echo apt install resolvconf
				return
			else
				if [ $secondElem = "-fix" ] 2>/dev/null ; then
					#Take interface name
					interface=$(echo "$(ip a | grep "global")" | awk '{print $NF}')

					read -p 'Ip fix: ' ip
					read -p 'Ip netmask: ' netMask
					read -p 'Ip gateway: ' gateWay

					echo rm /etc/network/interfaces
					echo touch /etc/network/interfaces

					echo "# The loopback network interface" >> /etc/network/interfaces
					echo "auto lo" >> /etc/network/interfaces
					echo "iface lo inet loopback" >> /etc/network/interfaces
					echo "iface $interface inet static" >> /etc/network/interfaces
					echo "address $ip" >> /etc/network/interfaces
					echo "netmask $netMask" >> /etc/network/interfaces
					echo "gateway $gateWay" >> /etc/network/interfaces

					echo systemctl restart networking
					echo systemctl ifdown $interface
					echo systemctl ifup $interface

					return
				elif [ $secondElem = "-auto" ] 2>/dev/null ; then
					#Take interface name
					interface=$(echo "$(ip a | grep "global")" | awk '{print $NF}')

					echo rm /etc/network/interfaces
					echo touch /etc/network/interfaces

					echo "# The loopback network interface" >> /etc/network/interfaces
					echo "auto lo" >> /etc/network/interfaces
					echo "iface lo inet loopback" >> /etc/network/interfaces
					echo "iface $interface inet dhcp" >> /etc/network/interfaces

					echo systemctl restart networking
					return
				else
					echo "[?] - \'nnvm -ip -auto\' to setup with DHCP or \'nnvm -ip -fix\' to setup fix ip address"
					return
				fi
			fi
		else
			echo "[?] - Bad ip request, try nnvm -help"
			return
		fi
	return
#<ip

#<tools
	elif [ $firstElem = "-tools" ] 2>/dev/null ; then

		if [ $firstElem = '-tools' ] 2>/dev/null && [ $secondElem != '' ] 2>/dev/null && [ -z "$thirdElem"] 2>/dev/null && [ -z "$fourthElem"] 2>/dev/null ; then
			if [ $secondElem = "-all" ] 2>/dev/null ; then
				echo $(apt install dnsutils)
				echo $(apt install ssh)
				echo $(apt install resolvconf)
				echo $(apt install net-tools)
				echo $(apt install tree)
				echo $(apt install vim)
			elif [ $secondElem = "-dnsutils" ] 2>/dev/null ; then
				echo $(apt install dnsutils)
			elif [ $secondElem = "-ssh" ] 2>/dev/null ; then
				echo $(apt install ssh)
			elif [ $secondElem = "-resolvconf" ] 2>/dev/null ; then
				echo $(apt install resolvconf)
			elif [ $secondElem = "-nett" ] 2>/dev/null ; then
				echo $(apt install net-tools)
			elif [ $secondElem = "-tree" ] 2>/dev/null ; then
				echo $(apt install tree)
			elif [ $secondElem = "-vim" ] 2>/dev/null ; then
				echo $(apt install vim)
			elif [ $secondElem = "-list" ] 2>/dev/null ; then
				echo 'shh : https://packages.debian.org/fr/stretch/ssh'
				echo 'dnsutils : https://packages.debian.org/fr/stretch/dnsutils'
				echo 'resolvconf : https://packages.debian.org/fr/sid/resolvconf'
				echo 'net-tools : https://packages.debian.org/fr/sid/net-tools'
				echo 'tree : https://debian-facile.org/doc:systeme:tree'
				echo 'vim : https://wiki.debian.org/fr/vim'
			fi
		else
			echo "\'nnvm -tools -<tool>\' to install it, or you can use \'nnvm -tools -all\' to install the full pack. You can list all tools with \'nnvm -tools -list\'"
			return
		fi

#>tools

#<ssh
	elif [ $firstElem = "-ssh" ] 2>/dev/null ; then
		if [ $firstElem = '-ssh' ] 2>/dev/null && [ $secondElem != '' ] 2>/dev/null && [ -z "$thirdElem"] 2>/dev/null && [ -z "$fourthElem"] 2>/dev/null ; then
			echo `dpkg-query -l ssh`
			if [ $? = "1" ] 2>/dev/null ; then
				echo $(apt install ssh)
				return
			else
				if [ $secondElem = "-auto" ] 2>/dev/null ; then
					echo `sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config`
					echo systemctl restart sshd.service
					return
				elif [ $secondElem = "-disabled" ] 2>/dev/null ; then
					echo `sed -i 's/PermitRootLogin yes/#PermitRootLogin prohibit-password/' /etc/ssh/sshd_config`
					echo systemctl restart sshd.service
					return
				else
					echo $'[?] - \'nnvm -ssh -auto\' to setup ssh or \'nnvm -ssh -disabled\ to disable ssh'
					return
				fi
			fi
		else
			echo " [?] - Bad ssh request, try nnvm -help"
			return
		fi

#>ssh

#>help
	elif [ $firstElem = "-help" ] 2>/dev/null ;then
			if [ $firstElem = '-help' ] 2>/dev/null && [ $secondElem != '' ] 2>/dev/null && [ -z "$thirdElem"] 2>/dev/null && [ -z "$fourthElem"] 2>/dev/null ; then
				if [ $secondElem = "-ip" ] 2>/dev/null ; then
					echo "[?] - \'nnvm -ip -auto\' to setup with DHCP or \'nnvm -ip -fix\' to setup fix ip address"
				elif [ $secondElem = "-ssh" ] 2>/dev/null ; then
					echo $'[?] - \'nnvm -ssh -auto\' to setup ssh or \'nnvm -ssh -disabled\ to disable ssh'
				elif [ $secondElem = "-log" ] 2>/dev/null ; then
					echo $'[?] - \'nnvm -log -r\' to setup receiver log\n \'nnvm -log -s\' to setup sender log'
				elif [ $secondElem = "-bye" ] 2>/dev/null ; then
					echo $'[?] - \'nnvm -bye\' to delete nnvm'
				elif [ $secondElem = "-tools" ] 2>/dev/null ; then
					echo "\'nnvm -tools -<tool>\' to install it, or you can use \'nnvm -tools -all\' to install the full pack. You can list all tools with \'nnvm -tools -list\'"
				else
					echo "[?] - $@  does not exist !"
					return
				fi
			else
				echo $'[?] - You can use the command to learn more : \'nnvm -help <possibilities>\''
            	echo $'[?] - -ip -ssh -log -bye -tools'
				return
			fi
			echo $'[?] - You can use the command to learn more : \'nnvm -help <possibilities>\''
            echo $'[?] - -ip -ssh -log -bye -tools'
		return
#<help

#>log
	elif [ $firstElem = "-log" ] 2>/dev/null ; then
		if [ $firstElem = '-log' ] 2>/dev/null && [ $secondElem != '' ] 2>/dev/null && [ -z "$thirdElem"] 2>/dev/null && [ -z "$fourthElem"] 2>/dev/null ; then
			#Check if pack > install
			echo `dpkg-query -l rsyslog`
			if [ $? = "1" ] 2>/dev/null
			then
				echo $(apt install rsyslog)
				return
			else

				if [ $secondElem = "-r" ] 2>/dev/null ; then
					echo `sed -i 's/#module(load="imudp")/module(load="imudp")/' /etc/rsyslog.conf`
					echo `sed -i 's/#input(type="imudp" port="514")/input(type="imudp" port="514")/' /etc/rsyslog.conf`
					return
				elif [ $secondElem = "-s" ] 2>/dev/null ; then
					echo `sed -i 's/#module(load="imudp")/module(load="imudp")/' /etc/rsyslog.conf`
					echo `sed -i 's/#input(type="imudp" port="514")/input(type="imudp" port="514")/' /etc/rsyslog.conf`
					read -p 'Ip sender: ' ipSend
					echo "*.* @$ipSend" >> /etc/rsyslog.conf
					return
				else
					echo $'[?] - \'nnvm -log -r\' to setup receiver log\n \'nnvm -log -s\' to setup sender log'
					return
				fi

			fi

		else
			echo " [?] - Bad log request, try nnvm -help"
			return
		fi
		return
#<log
	else 
		echo "[?] - Error try nnvm -help"
		return

	fi

}

if [ $1 != '' ] 2>/dev/null ; then
        nnvmConstructor

else
	echo "[?] - Error try nnvm -help"

fi
