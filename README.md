# CloudFormation Template Format Converters
[![Circle CI](https://circleci.com/gh/bonusbits/cfn_converter/tree/master.svg?style=shield)](https://circleci.com/gh/bonusbits/cfn_converter/tree/master)

## Purpose
A simply Ruby script to convert CloudFormation Template from JSON to YAML format or YAML to JSON.
It will automatically convert to the opposite format based on the file extension passed to the script.

## Usage
Run the Ruby script with a single argument being the JSON or YAML full path and filename. 
A converted file with the same name will be created in the same location of the original file.

It is set to not overwrite by default. It will bail out if the same output filename is found.
 
First rename .template to .json or .yml

### System Ruby

```bash
./cfn-converter -f json_file.json
./cfn-converter -f yaml_file.yml
```
### ChefDK Ruby

```bash
/opt/chefdk/embedded/bin/ruby cfn-converter.rb -f json_file.json
/opt/chefdk/embedded/bin/ruby cfn-converter.rb -f yaml_file.yml
```

## Access Options
1. Create alias

    ```bash
    alias cfn-converter="/Users/username/cfn_converter/cfn-converter.rb"
    ```
2. Symlink the ruby script to a place in path

    ```bash
    ln -s "/Users/username/cfn_converter/cfn-converter.rb" /usr/local/bin/cfn-converter
    ```
3. Add cloned repo path to environment path

    ```bash
    PATH="/Users/username/cfn_converter:$PATH"
    ```
    
### Convert Multiple Recursively
Here's a way in BASH to convert all JSONs to YAMLs. I used this to convert the whole [cloudformation_templates repo](https://github.com/bonusbits/cloudformation_templates)

Basically find all JSON files from current working directory on down. Exclude any with **parameters** or **snippets** in the name.

```bash
find . -name '*.json' ! -name '*parameters*' ! -name 'snippets' -exec /usr/local/bin/cfn-converter -f {} \;
```
    