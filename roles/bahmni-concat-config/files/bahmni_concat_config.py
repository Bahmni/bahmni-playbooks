import json
import glob
import ntpath


def concat_config(fileName, path):
    result = {}
    jsonfiles = glob.glob(path + "*.json")
    jsFiles = glob.glob(path + "*.js")
    if len(jsFiles) > 0:
        for jsfile in jsFiles:
            jsonfiles.append(jsfile)

    for file in jsonfiles:
        with open(file, "rb") as infile:
            if ntpath.basename(file).endswith('.json'):
                file_name = ntpath.basename(file)
                result[file_name] = json.load(infile)
            else:
                file_name = ntpath.basename(file)
                result[file_name] = infile.read().replace('\n', '').replace('\t', '')

    with open(path + fileName + ".json", "w+") as outfile:
        json.dump(result, outfile)



paths = {'home' :'/var/www/bahmni_config/openmrs/apps/home/',
         'registration': '/var/www/bahmni_config/openmrs/apps/registration/' ,
         'clinical': '/var/www/bahmni_config/openmrs/apps/clinical/'
        }

for key in paths:
    concat_config(key, paths[key])