FROM phusion/baseimage
MAINTAINER hfeng <hfent@tutum.co>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pptpd
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install iptables

#set username and password
RUN echo "user * pass *" >> /etc/ppp/chap-secrets

#config pptpd address
RUN echo "localip 10.0.0.1" >> /etc/pptpd.conf
RUN echo "remoteip 10.0.0.100-200" >> /etc/pptpd.conf

#config dns
RUN echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
RUN echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options

#config IPV4 forwarding
RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

#RUN sysctl -p
#RUN /etc/init.d/pptpd restart

#set iptables forwording rules
RUN sed -i 's/^$/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE/' /etc/rc.local

EXPOSE 1723

CMD /sbin/my_init -- pptpd --fg
