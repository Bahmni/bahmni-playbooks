#!/usr/bin/python

import subprocess
p = subprocess.Popen("bahmni -ilocal version", stdout=subprocess.PIPE, shell=True)
(output, err) = p.communicate()
array = output.split("\n")
print "Content-type: text/html"
print
print "<html><head>"
print "<title>Bahmni Packages Version</title>"
print ""
print "<style>"
print"body {font-family: 'Trebuchet MS', Helvetica, sans-serif;font-size: 15px;width: 600px;margin: 30px auto 0;}h3{text-align:center;text-decoration: underline;}ul {margin: 0;padding: 0;list-style: none;}ul li {margin-bottom: 10px;display: block;padding: 5px 10px;}ul li:nth-child(even) {background: rgba(255, 235, 59, 0.24);}ul li:nth-child(odd) {background: rgba(188, 188, 188, 0.11);}"
print "</style>"
print "</head><body>"
print "<h3>Bahmni Packages Version</h3>"
print "<ul>"
for element in array:
    print"<li>"
    print element
    print"</li>"
print "</ul>"
print "</body></html>"