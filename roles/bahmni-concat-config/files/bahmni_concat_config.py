import glob
import json
import ntpath
import os


def concat_config(fileName, path, offline_path):
    result = {}
    jsonfiles = glob.glob(path + "*.json")
    jsFiles = glob.glob(path + "*.js")
    if len(jsFiles) > 0:
        for jsfile in jsFiles:
            jsonfiles.append(jsfile)

    for file in jsonfiles:
        file_name = ntpath.basename(file)
        offline_file = glob.glob(offline_path + file_name)
        if os.path.isfile(offline_path + file_name):
            file = offline_file[0]
        with open(file, "rb") as infile:
            if ntpath.basename(file).endswith('.json'):
                file_name = ntpath.basename(file)
                result[file_name] = json.load(infile)
            else:
                file_name = ntpath.basename(file)
                result[file_name] = infile.read().replace('\n', '').replace('\t', '')

    with open(path + fileName + ".json", "w+") as outfile:
        json.dump(result, outfile)


paths = {'home': '/var/www/bahmni_config/openmrs/apps/home/',
         'registration': '/var/www/bahmni_config/openmrs/apps/registration/',
         'clinical': '/var/www/bahmni_config/openmrs/apps/clinical/',
         'dbNameCondition': '/var/www/bahmni_config/openmrs/apps/dbNameCondition/',
         }

offlinePaths = {
    'home': '/var/www/bahmni_config/offline/openmrs/apps/home/',
    'registration': '/var/www/bahmni_config/offline/openmrs/apps/registration/',
    'clinical': '/var/www/bahmni_config/offline/openmrs/apps/clinical/',
    'dbNameCondition': '/var/www/bahmni_config/offline/openmrs/apps/dbNameCondition/',
}

for key in paths:
    concat_config(key, paths[key], offlinePaths[key])
