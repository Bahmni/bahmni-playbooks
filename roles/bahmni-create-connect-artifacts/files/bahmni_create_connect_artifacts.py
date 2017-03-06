import httplib
import sys

username = sys.argv[1]
password = sys.argv[2]
url = "/openmrs/ws/rest/v1/bahmniconnect/initsync?username=%s&password=%s" % (username, password)
host = "127.0.0.1"

connection = httplib.HTTPConnection(host)
connection.request("POST", url)

response = connection.getresponse()
if response.status == 200:
    print "Creation of artifacts is started..."
elif response.status == 503:
    print "Make sure OpenMRS is started"
    sys.exit(1)
else:
    print "Invalid Username/Password"
    sys.exit(1)
