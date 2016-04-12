#!/usr/bin/python
from optparse import OptionParser

usage = "usage: %prog [options] JOBNAME"
parser = OptionParser(usage=usage, version="1.0")
parser.add_option("-H", "--host", dest="host", help="host", metavar="HOST")
parser.add_option("-p", "--port", dest="port", help="port", metavar="PORT")
parser.add_option("-u", "--url", dest="url", help="url", metavar="URL")
parser.add_option("-a", "--authorization", dest="authorization", help="Username:password on sites with basic authentication", metavar="AUTH_PAIR")

(options, args) = parser.parse_args()
if len(args) < 1:
	parser.error("please supply the jobName")

import urllib2
from base64 import b64encode
import json
import sys
import socket

returnCode = None

if options.port: 
	serverUrl = "http://%(host)s:%(port)s%(url)s" % vars(options)
else:
	serverUrl = "http://%(host)s%(url)s" % vars(options)

socket.setdefaulttimeout(5)
request = urllib2.Request(serverUrl)

if (not options.authorization is None):
	request.add_header('Authorization', 'Basic ' + b64encode(options.authorization))

try:
	response = urllib2.urlopen(request)
except urllib2.HTTPError as e:
	print "CRITICAL: HTTP Error: {0} : \n {1}".format(e.code, e.read())
	if returnCode is None:
		returnCode = 2
except urllib2.URLError as e:
	print "CRITICAL: URL Error: {0} ".format(e.reason)
	if returnCode is None:
		returnCode = 2

jobs = json.load(response)   

for arg in args:
	jobName = arg
	job = next((j for j in jobs if jobName in j['taskClass']), None)

	if (job is None):
		print "CRITICAL: Job : %s not defined." % jobName
		if returnCode is None:
			returnCode = 2

	elif (not job['started']):
		print "CRITICAL: Job : %s has not started." % jobName
		if returnCode is None:
			returnCode = 2

	else:
		print "OK: Job : %s has been scheduled and started" % jobName


if returnCode is None:
	returnCode = 0

print jobs
print "RETURN CODE {0}".format(returnCode)
print "\n"
sys.exit(returnCode)
