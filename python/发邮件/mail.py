#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import os
import sys
import getopt
import smtplib
from email.MIMEText import MIMEText
from email.MIMEMultipart import MIMEMultipart
from subprocess import *
reload(sys)
sys.setdefaultencoding('utf8')


def sendqqmail(username, password, mailfrom, mailto, subject, content):
    gserver = 'smtp.exmail.qq.com'
    gport = 465

    try:
        # msg = MIMEText(unicode(content).encode('utf-8')) //如果发送的邮件有乱码，可以尝试把这行改成如下：
        msg = MIMEText(content, 'plan', 'utf-8')
        msg['from'] = mailfrom
        msg['to'] = mailto
        msg['Reply-To'] = mailfrom
        msg['Subject'] = subject

        smtp = smtplib.SMTP_SSL(gserver, gport)
        smtp.set_debuglevel(0)
        smtp.ehlo()
        smtp.login(username, password)

        smtp.sendmail(mailfrom, mailto, msg.as_string())
        smtp.close()
    except Exception, err:
        print "Send mail failed. Error: %s" % err


def main():
    to = sys.argv[1]
    subject = sys.argv[2]
    content = sys.argv[3]
    sendqqmail('发件邮箱地址', '授权码', '发件邮箱地址', to, subject, content)


if __name__ == "__main__":
    main()
