# CloudFormation Template Format Converters
[![Version](https://img.shields.io/badge/version-v1.0.2-blue.svg)](https://github.com/bonusbits/cfn_converter)
[![Circle CI](https://circleci.com/gh/bonusbits/cfn_converter/tree/master.svg?style=shield)](https://circleci.com/gh/bonusbits/cfn_converter/tree/master)
[![Join the chat at https://gitter.im/bonusbits](https://badges.gitter.im/bonusbits/bonusbits.svg)](https://gitter.im/bonusbits?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![GitHub issues](https://img.shields.io/github/issues/bonusbits/cfn_converter.svg)](https://github.com/bonusbits/cfn_converter/issues)

## Purpose
A simply Ruby script to convert CloudFormation Template from JSON to YAML format or YAML to JSON.
It will automatically convert to the opposite format based on the file extension passed to the script.

## Usage
Run the Ruby script with a single argument being the JSON or YAML full path and filename. 
A converted file with the same name will be created in the same location of the original file.

It is set to not overwrite by default. It will bail out if the same output filename is found.
 
First rename .template to .json or .yml depending on the file contents format.

## Symlink (Optional)
Create a symlink to the ruby script to a path location so it can be called from any working directory.

1. Symlink the ruby script to a place in the path

    ```bash
     if [ ! -h "/usr/local/bin/cfnc" ]; then
       ln -s "/path/to/clone/cfn_converter/cfn-converter.rb" /usr/local/bin/cfnc
     fi
    ```
    
### Convert Single Template Example

```bash
cfnc -f json_file.json
cfnc -f yaml_file.yml
```

    
### Convert Multiple Recursively Example
Here's a way in BASH to convert all JSONs to YAMLs. I used this to convert the whole [cloudformation_templates repo](https://github.com/bonusbits/cloudformation_templates)

Basically find all JSON files from current working directory on down. Exclude any with **parameters** or **snippets** in the name.

```bash
find . -name '*.json' ! -name '*parameters*' ! -name 'snippets' -exec cfnc -f {} \;
```
    